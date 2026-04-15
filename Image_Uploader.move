module 0xYOUR_ADDRESS::image_vault {
    use std::string::{Self, String};
    use aptos_framework::object::{Self, Object};
    use aptos_framework::signer;

    struct ImageRecord has key {
        blob_name: String,
        owner: address,
    }

    public entry fun register_image(account: &signer, blob_name: String) {
        let owner = signer::address_of(account);
        
        let constructor_ref = object::create_named_object(account, string::bytes(&blob_name));
        let object_signer = object::generate_signer(&constructor_ref);
        
        move_to(&object_signer, ImageRecord {
            blob_name,
            owner,
        });
        
        // Optional: emit event or create NFT-like token here
    }

    // View function (for frontend)
    #[view]
    public fun get_image_record(obj: Object<ImageRecord>): (String, address) {
        let record = borrow_global<ImageRecord>(object::object_address(&obj));
        (record.blob_name, record.owner)
    }
}
