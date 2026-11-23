# Bounded SDK Agent Session (r)

This optional module binds the generated SDK operations, argument schemas, and
effect signatures into a caller-controlled bounded agent session.

- Entrypoint: `omniwrap_agent_session` (`R/agent_session.R`)
- Discovery metadata: `agent-session.json` (`omniwrap.agent-session-discovery/v1`)
- Code map: embedded under `code_map` (`omniwrap.agent-code-map/v1`)
- Checkpoint protocol: `omniwrap.agent-session/v1`

## Safety boundary

- Mutations are denied by default (`allowMutations=false`) until explicitly permitted.
- Step and tool-call ceilings are enforced before dispatching an SDK call.
- No hosted model or arbitrary-code sandbox runs inside this package.
