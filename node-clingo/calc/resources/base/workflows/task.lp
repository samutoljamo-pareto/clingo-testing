workflow("base/workflows/task").
workflowState("base/workflows/task", "Open", "initial").
workflowState("base/workflows/task", "In progress", "active").
workflowState("base/workflows/task", "Closed as done", "closed").
workflowState("base/workflows/task", "Closed as not applicable", "closed").
workflowTransition("base/workflows/task", "Create", "", "Open").
workflowTransition("base/workflows/task", "Reopen", "*", "Open").
workflowTransition("base/workflows/task", "Start progress", "Open", "In progress").
workflowTransition("base/workflows/task", "Done", "In progress", "Closed as done").
workflowTransition("base/workflows/task", "Review as not applicable", "Open", "Closed as not applicable").
workflowTransition("base/workflows/task", "Review as not applicable", "In progress", "Closed as not applicable").
