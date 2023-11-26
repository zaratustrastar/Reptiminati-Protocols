from starkware.starknet.common.syscalls import get_block_timestamp
from starkware.cairo.common.math import assert_nn

"""
Import dojo enjine contract and interfaces
"""
from dojo_enjine.contract import Enjine
from dojo_enjine.interfaces import IERC20, IERC721


"""
Dojo enjine setup 
"""

ENJ_TOKEN = Enjine.register_erc20(
    name="ENJ",
    symbol="ENJ",
    decimals=18
)

CARD_NFT = Enjine.register_erc721(
    name="LuckyCard",
    symbol="LCARD"  
)


""" 
Card struct
"""

@dataclass
struct Card:
    id: felt
    enj_cost: Uint256 # set during minting
    

"""
 Mint card NFT
"""
 
@external
func mint_card{
    syscall_ptr: felt*,  
    range_check_ptr,
    enjine_ptr: Enjine*
}(token_id: felt) -> (erc721_token_id: Uint256):

    ENJ_TOKEN.transfer_from(
        sender=get_caller_address(),
        recipient=ADDRESS, # contract address
        amount=card.enj_cost
    )  

    return CARD_NFT.mint(to=get_caller_address(), token_id=token_id)
