workflow("base/workflows/recurringTask").
workflowState("base/workflows/recurringTask", "Open", "initial").
workflowState("base/workflows/recurringTask", "In progress", "active").
workflowState("base/workflows/recurringTask", "Closed as done", "closed").
workflowState("base/workflows/recurringTask", "Closed as not applicable", "closed").
workflowTransition("base/workflows/recurringTask", "Create", "", "Open").
workflowTransition("base/workflows/recurringTask", "Reopen", "*", "Open").
workflowTransition("base/workflows/recurringTask", "Start progress", "Open", "In progress").
workflowTransition("base/workflows/recurringTask", "Done", "In progress", "Closed as done").
workflowTransition("base/workflows/recurringTask", "Review as OK", "Closed as done", "Closed as done").
workflowTransition("base/workflows/recurringTask", "Review as not applicable", "*", "Closed as not applicable").
