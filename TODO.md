TODO/Questions

General:
1. Wrap with Docker + Docker Compose
1. Cleanup unused code
1. Improve documentation
1. Write more specs
1. Improve test coverage
1. Update code for prod
1. Better error handling
1. User-friendly responses from API

Users:
1. DB Role could be enum
1. Re-think DB Users, it could be Table-Per-Type (TPT)
1. Replace RBAC approach with ABAC
1. Isolate Auth-n/Auth-z mechanism
1. Access, Refresh tokens (?)
1. Track tokens in DB (?)
1. POW adaptation is quite dirty (EnsureRole, AuthFlow)

Tasks:
1. Tasks are not assigned right now (driver_id) =>
1. Task status could be changed by different drivers (assigned for example)
1. Task status is not validated (clarify bisuness rules, example: whether it possible to change status when it's 'done')
1. Return distance from api when searching 
1. Filtering, paging
