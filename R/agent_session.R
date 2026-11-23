OMNIWRAP_AGENT_SESSION_SOURCE_SHA256 <- "2289bcb0d661bdea6dd47c7967f37aace7d3a152e18e7d2f64c08514fb73e795"
OMNIWRAP_AGENT_SESSION_OPERATIONS_COUNT <- 16L

omniwrap_agent_session <- function(max_steps = 8L, max_tool_calls = 16L, allow_mutations = FALSE, allowed_operations = character(0)) {
  env <- new.env(parent = emptyenv())
  env$max_steps <- max(1L, as.integer(max_steps))
  env$max_tool_calls <- max(1L, as.integer(max_tool_calls))
  env$allow_mutations <- isTRUE(allow_mutations)
  env$allowed_operations <- as.character(allowed_operations)
  env$steps_completed <- 0L
  env$tool_calls_completed <- 0L
  env$can_invoke <- function(operation_id, is_mutation = FALSE) {
    if (env$steps_completed >= env$max_steps || env$tool_calls_completed >= env$max_tool_calls) return(FALSE)
    if (isTRUE(is_mutation) && !env$allow_mutations) return(FALSE)
    length(env$allowed_operations) == 0L || (as.character(operation_id) %in% env$allowed_operations)
  }
  env$record_step <- function(tool_calls = 1L) {
    env$steps_completed <- env$steps_completed + 1L
    env$tool_calls_completed <- env$tool_calls_completed + max(0L, as.integer(tool_calls))
  }
  env$checkpoint <- function() {
    list(protocol_version = "omniwrap.agent-session/v1", source_sha256 = OMNIWRAP_AGENT_SESSION_SOURCE_SHA256, steps_completed = env$steps_completed, tool_calls_completed = env$tool_calls_completed)
  }
  env
}
