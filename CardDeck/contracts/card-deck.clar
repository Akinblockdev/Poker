(define-constant CONTRACT_OWNER tx-sender)
(define-constant DECK_SIZE u52)
(define-constant CARDS_PER_SUIT u13)

(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_INVALID_CARD (err u101))
(define-constant ERR_DECK_IN_USE (err u102))
(define-constant ERR_NO_DECK_FOUND (err u103))
(define-constant ERR_CARD_ALREADY_DEALT (err u104))

(define-map cards 
    {deck-id: uint, card-index: uint} 
    {
        suit: uint,
        value: uint,
        dealt: bool,
        deal-height: uint
    }
)

(define-map decks
    {deck-id: uint}
    {
        in-use: bool,
        created-at: uint,
        shuffled: bool,
        seed: uint,
        cards-dealt: uint
    }
)

(define-data-var deck-counter uint u0)

(define-private (init-card (deck-id uint) (card-index uint))
    (map-set cards
        {deck-id: deck-id, card-index: card-index}
        {
            suit: (+ u1 (/ card-index CARDS_PER_SUIT)),
            value: (+ u2 (mod card-index CARDS_PER_SUIT)),
            dealt: false,
            deal-height: u0
        }
    )
)

(define-public (initialize-deck (seed uint))
    (let ((new-deck-id (+ (var-get deck-counter) u1)))
        (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
        (var-set deck-counter new-deck-id)
        (map-set decks 
            {deck-id: new-deck-id} 
            {
                in-use: true,
                created-at: block-height,
                shuffled: false,
                seed: seed,
                cards-dealt: u0
            }
        )
        ;; Initialize all 52 cards
        (init-card new-deck-id u0)
        (init-card new-deck-id u1)
        (init-card new-deck-id u2)
        (init-card new-deck-id u3)
        (init-card new-deck-id u4)
        (init-card new-deck-id u5)
        (init-card new-deck-id u6)
        (init-card new-deck-id u7)
        (init-card new-deck-id u8)
        (init-card new-deck-id u9)
        (init-card new-deck-id u10)
        (init-card new-deck-id u11)
        (init-card new-deck-id u12)
        (init-card new-deck-id u13)
        (init-card new-deck-id u14)
        (init-card new-deck-id u15)
        (init-card new-deck-id u16)
        (init-card new-deck-id u17)
        (init-card new-deck-id u18)
        (init-card new-deck-id u19)
        (init-card new-deck-id u20)
        (init-card new-deck-id u21)
        (init-card new-deck-id u22)
        (init-card new-deck-id u23)
        (init-card new-deck-id u24)
        (init-card new-deck-id u25)
        (init-card new-deck-id u26)
        (init-card new-deck-id u27)
        (init-card new-deck-id u28)
        (init-card new-deck-id u29)
        (init-card new-deck-id u30)
        (init-card new-deck-id u31)
        (init-card new-deck-id u32)
        (init-card new-deck-id u33)
        (init-card new-deck-id u34)
        (init-card new-deck-id u35)
        (init-card new-deck-id u36)
        (init-card new-deck-id u37)
        (init-card new-deck-id u38)
        (init-card new-deck-id u39)
        (init-card new-deck-id u40)
        (init-card new-deck-id u41)
        (init-card new-deck-id u42)
        (init-card new-deck-id u43)
        (init-card new-deck-id u44)
        (init-card new-deck-id u45)
        (init-card new-deck-id u46)
        (init-card new-deck-id u47)
        (init-card new-deck-id u48)
        (init-card new-deck-id u49)
        (init-card new-deck-id u50)
        (init-card new-deck-id u51)
        (ok new-deck-id)
    )
)

(define-public (deal-card (deck-id uint) (position uint))
    (let (
        (deck-data (unwrap! (map-get? decks {deck-id: deck-id}) ERR_NO_DECK_FOUND))
        (card-data (unwrap! (map-get? cards {deck-id: deck-id, card-index: position}) ERR_INVALID_CARD))
    )
        (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
        (asserts! (get in-use deck-data) ERR_NO_DECK_FOUND)
        (asserts! (< position DECK_SIZE) ERR_INVALID_CARD)
        (asserts! (not (get dealt card-data)) ERR_CARD_ALREADY_DEALT)
        
        (map-set cards
            {deck-id: deck-id, card-index: position}
            (merge card-data {
                dealt: true,
                deal-height: block-height
            })
        )
        (map-set decks
            {deck-id: deck-id}
            (merge deck-data {
                cards-dealt: (+ (get cards-dealt deck-data) u1)
            })
        )
        (ok true)
    )
)

(define-read-only (get-card (deck-id uint) (position uint))
    (let ((card-data (unwrap! (map-get? cards {deck-id: deck-id, card-index: position}) ERR_INVALID_CARD)))
        (ok {
            suit: (get suit card-data),
            value: (get value card-data),
            dealt: (get dealt card-data),
            deal-height: (get deal-height card-data)
        })
    )
)

(define-read-only (get-deck-status (deck-id uint))
    (let ((deck-data (unwrap! (map-get? decks {deck-id: deck-id}) ERR_NO_DECK_FOUND)))
        (ok {
            in-use: (get in-use deck-data),
            cards-dealt: (get cards-dealt deck-data),
            created-at: (get created-at deck-data),
            shuffled: (get shuffled deck-data)
        })
    )
)

(define-read-only (is-deck-active (deck-id uint))
    (match (map-get? decks {deck-id: deck-id})
        deck-data (get in-use deck-data)
        false
    )
)

(define-public (retire-deck (deck-id uint))
    (let ((deck-data (unwrap! (map-get? decks {deck-id: deck-id}) ERR_NO_DECK_FOUND)))
        (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
        (asserts! (get in-use deck-data) ERR_NO_DECK_FOUND)
        (map-set decks
            {deck-id: deck-id}
            (merge deck-data {
                in-use: false
            })
        )
        (ok true)
    )
)