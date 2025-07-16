# game_performance_tuning Role

This role applies system and user-level optimizations for gaming performance. It supports:
- Kernel and driver tuning
- Power and graphics settings
- Optional: overclocking, network tweaks

## Variables
- `tuning_profile`: Performance profile (e.g., `balanced`, `high_performance`)
- `tuning_apply_to`: User(s) or system-wide

## Compliance
- Only applies safe, tested optimizations by default

## Testing
- Molecule scenario included for performance and stability checks
