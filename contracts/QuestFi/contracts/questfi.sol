import starkware.starknet as sn

"""
Structs
"""

@sn.dataclass
struct User:
    address: sn.felt
    xp: sn.felt

@sn.dataclass  
struct Phase:
    id: sn.felt
    name: str
    apps: List[str]

"""
Storage
"""

users: Dict[sn.felt, User] = {}
phases: Dict[sn.felt, Phase] = {} 
apps: Dict[str, Dict[str, sn.felt]] = {} # app_id -> {activity -> score}

"""
External contracts
"""

@external
def update_user_xp{syscall_ptr: sn.felt*(sn.felt)}(_address: sn.felt, _xp: sn.felt):
    user = users.get(_address)
    if user is None:
        user = User(address=_address, xp=0)
        users[_address] = user
    
    user.xp += _xp

"""    
Functions
"""
    
@view
func get_phase_by_id{syscall_ptr: sn.felt*(sn.felt)}(_id: sn.felt) -> (Phase | None):
    return phases.get(_id)

@external    
func add_phase{syscall_ptr: sn.felt*(sn.felt)}(
    _id: sn.felt, 
    _name: str,
    _apps: List[str]
):
    phases[_id] = Phase(id=_id, name=_name, apps=_apps)
    
@view  
func get_app_scores{syscall_ptr: sn.felt*(sn.felt)}(_app_id: str) -> Dict[str, sn.felt]:
    return apps.get(_app_id)

@external
func add_app_scores{syscall_ptr: sn.felt*(sn.felt)}(
    _app_id: str,
    _activities: Dict[str, sn.felt]  
):
    apps[_app_id] = _activities
    
"""
More functions, logic, tests etc.
"""
