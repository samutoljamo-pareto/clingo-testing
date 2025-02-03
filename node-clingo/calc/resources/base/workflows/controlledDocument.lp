workflow("base/workflows/controlledDocument").
workflowState("base/workflows/controlledDocument", "Draft", "initial").
workflowState("base/workflows/controlledDocument", "Reviewed", "initial").
workflowState("base/workflows/controlledDocument", "Approved", "closed").
workflowState("base/workflows/controlledDocument", "Archived", "closed").
workflowTransition("base/workflows/controlledDocument", "Create", "", "Draft").
workflowTransition("base/workflows/controlledDocument", "Review as OK", "Draft", "Reviewed").
workflowTransition("base/workflows/controlledDocument", "Review as OK", "Approved", "Reviewed").
workflowTransition("base/workflows/controlledDocument", "Approve", "Reviewed", "Approved").
workflowTransition("base/workflows/controlledDocument", "Archive", "*", "Archived").
workflowTransition("base/workflows/controlledDocument", "Reopen", "*", "Draft").
