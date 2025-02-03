workflow("base/workflows/page").
workflowState("base/workflows/page", "Draft", "initial").
workflowState("base/workflows/page", "Ready", "closed").
workflowState("base/workflows/page", "Deprecated", "closed").
workflowTransition("base/workflows/page", "Create", "", "Draft").
workflowTransition("base/workflows/page", "Content ready", "Draft", "Ready").
workflowTransition("base/workflows/page", "Archive", "*", "Deprecated").
workflowTransition("base/workflows/page", "Reopen", "*", "Draft").
