workflow("base/workflows/decision").
workflowState("base/workflows/decision", "Draft", "initial").
workflowState("base/workflows/decision", "Approved", "closed").
workflowState("base/workflows/decision", "Deprecated", "closed").
workflowTransition("base/workflows/decision", "Create", "", "Draft").
workflowTransition("base/workflows/decision", "Approve", "Draft", "Approved").
workflowTransition("base/workflows/decision", "Archive", "*", "Deprecated").
workflowTransition("base/workflows/decision", "Reopen", "*", "Draft").
