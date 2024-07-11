/*
创建一个 CandyTreasuryCapHolder 对象结构体，并更新 sui_fren::init 和 mint 函数以使用它来允许用户自由铸造糖果。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::string::String;
    use std::vector;
    use sui::event;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    struct CANDY has drop {}

    // 这里添加新结构体

    fun init(otw: CANDY, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            otw,
            9,
            b"CANDY",
            b"SuiFren Candy",
            b"Candies to level up SuiFren"
            option::none(),
            ctx,
        );
        transfer::public_transfer(metadata, tx_context::sender(ctx));
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    entry fun mint(treasury_cap: &mut TreasuryCap<Candy>, amount: u64, ctx: &mut TxContext) {
        coin::mint_and_transfer(treasury_cap, 1000, tx_context::sender(ctx), ctx);
    }
}