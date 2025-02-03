

%
% Common definitions for all Cards projects
%

% parent and ancestor
ancestor(A, C) :- parent(A, C), card(A), card(B).
ancestor(A, C) :- parent(A, B), ancestor (B, C), card(A), card(B), card(C).

% if the card type is given, then it's a card
card(C) :- field(C, "cardType", _).

% data types for non-shortText default values

dataType(Card, "lastUpdated", "dateTime") :-
    field(Card, "lastUpdated", _).

% add workflow state category as a calculated field for Cards
field(Card, "workflowStateCategory", Category) :-
    card(Card),
    field(Card, "workflowState", State),
    field(Card, "cardType", CardType),
    field(CardType, "workflow", Workflow),
    workflowState(Workflow, State, Category).


% data types of fields
dataType(Key, Field, DataType) :-
    field(Key, Field, _),
    fieldType(Field),
    field(Field, "dataType", DataType).

% data types for enum values

dataType((FieldType, EnumValue), "index", "integer") :-
    enumValue(FieldType, EnumValue).

dataType((FieldType, EnumValue), "enumDisplayValue", "shortText") :-
    enumValue(FieldType, EnumValue).

dataType((FieldType, EnumValue), "enumDescription", "longText") :-
    enumValue(FieldType, EnumValue).

dataType((FieldType, EnumValue), "enumValue", "longText") :-
    enumValue(FieldType, EnumValue).

% descendants of hidden cards are hidden

hiddenInTreeView(Card) :-
    ancestor(Card, Ancestor),
    hiddenInTreeView(Ancestor).
% /home/samu/projects/cyberismo-docs/.calc/cards
% docs_10
field(docs_10, "title", "Overview").
field(docs_10, "cardType", "base/cardTypes/page").
field(docs_10, "workflowState", "Ready").
field(docs_10, "lastTransitioned", "2024-08-01T08:00:14.570Z").
field(docs_10, "lastUpdated", "2024-11-15T16:37:13.184Z").
field(docs_10, "rank", "0|b").

% docs_11
field(docs_11, "title", "Solution architecture").
field(docs_11, "cardType", "base/cardTypes/page").
field(docs_11, "workflowState", "Ready").
field(docs_11, "rank", "0|c").
field(docs_11, "lastUpdated", "2024-10-21T10:43:54.401Z").
field(docs_11, "lastTransitioned", "2024-10-21T10:43:54.376Z").

% docs_13
field(docs_13, "title", "Installing, updating and uninstalling").
field(docs_13, "cardType", "base/cardTypes/page").
field(docs_13, "workflowState", "Ready").
field(docs_13, "rank", "0|e").
field(docs_13, "lastUpdated", "2024-11-05T19:31:02.718Z").
field(docs_13, "lastTransitioned", "2024-10-21T10:43:58.415Z").

% docs_14
field(docs_14, "title", "Security considerations").
field(docs_14, "cardType", "base/cardTypes/page").
field(docs_14, "workflowState", "Ready").
field(docs_14, "rank", "0|f").
field(docs_14, "lastUpdated", "2024-10-21T10:44:05.862Z").
field(docs_14, "lastTransitioned", "2024-10-21T10:44:05.839Z").

% docs_17
field(docs_17, "title", "Installing Cyberismo").
field(docs_17, "cardType", "base/cardTypes/page").
field(docs_17, "workflowState", "Draft").
field(docs_17, "rank", "0|a").
field(docs_17, "lastUpdated", "2025-01-14T13:19:23.835Z").
parent(docs_17, docs_13).

% docs_19
field(docs_19, "title", "Updating Cyberismo").
field(docs_19, "cardType", "base/cardTypes/page").
field(docs_19, "workflowState", "Draft").
field(docs_19, "rank", "0|m").
field(docs_19, "lastUpdated", "2025-01-14T13:17:12.305Z").
parent(docs_19, docs_13).

% docs_2
field(docs_2, "title", "Getting started").
field(docs_2, "cardType", "base/cardTypes/page").
field(docs_2, "workflowState", "Ready").
field(docs_2, "rank", "0|g").
field(docs_2, "lastUpdated", "2024-11-05T19:31:15.953Z").
field(docs_2, "lastTransitioned", "2024-10-21T10:44:09.464Z").

% docs_24
field(docs_24, "title", "Uninstalling Cyberismo").
field(docs_24, "cardType", "base/cardTypes/page").
field(docs_24, "workflowState", "Draft").
field(docs_24, "rank", "0|z").
field(docs_24, "lastUpdated", "2025-01-14T13:04:00.776Z").
parent(docs_24, docs_13).

% docs_25
field(docs_25, "title", "Fields and field types").
field(docs_25, "cardType", "base/cardTypes/page").
field(docs_25, "workflowState", "Draft").
field(docs_25, "rank", "0|aaaaaan").
field(docs_25, "lastUpdated", "2024-11-15T17:04:21.573Z").
parent(docs_25, docs_6).

% docs_26
field(docs_26, "title", "Workflows").
field(docs_26, "cardType", "base/cardTypes/page").
field(docs_26, "workflowState", "Draft").
field(docs_26, "rank", "0|a").
field(docs_26, "lastUpdated", "2024-11-15T17:03:58.081Z").
parent(docs_26, docs_6).

% docs_27
field(docs_27, "title", "Card types").
field(docs_27, "cardType", "base/cardTypes/page").
field(docs_27, "workflowState", "Draft").
field(docs_27, "rank", "0|aaaaab").
field(docs_27, "lastUpdated", "2024-11-15T17:04:43.710Z").
parent(docs_27, docs_6).

% docs_28
field(docs_28, "title", "Introduction to Answer Set Programming").
field(docs_28, "cardType", "base/cardTypes/page").
field(docs_28, "workflowState", "Draft").
field(docs_28, "rank", "0|d").
field(docs_28, "lastUpdated", "2024-09-01T18:54:31.176Z").
parent(docs_28, docs_9).

% docs_29
field(docs_29, "title", "Mapping the Cyberismo content to a logic program").
field(docs_29, "cardType", "base/cardTypes/page").
field(docs_29, "workflowState", "Draft").
field(docs_29, "rank", "0|g").
field(docs_29, "lastUpdated", "2024-11-15T16:29:53.069Z").
parent(docs_29, docs_9).

% docs_2eteajqw
field(docs_2eteajqw, "title", "Copyright").
field(docs_2eteajqw, "cardType", "base/cardTypes/page").
field(docs_2eteajqw, "workflowState", "Ready").
field(docs_2eteajqw, "rank", "0|l").
field(docs_2eteajqw, "lastUpdated", "2024-10-21T10:44:31.541Z").
field(docs_2eteajqw, "lastTransitioned", "2024-10-21T10:44:31.517Z").

% docs_3
field(docs_3, "title", "Using the Cyberismo command line interface").
field(docs_3, "cardType", "base/cardTypes/page").
field(docs_3, "workflowState", "Ready").
field(docs_3, "rank", "0|h").
field(docs_3, "lastUpdated", "2024-11-17T15:06:16.400Z").
field(docs_3, "lastTransitioned", "2024-10-21T10:44:22.009Z").

% docs_30
field(docs_30, "title", "Calculated fields").
field(docs_30, "cardType", "base/cardTypes/page").
field(docs_30, "workflowState", "Draft").
field(docs_30, "rank", "0|m").
field(docs_30, "lastUpdated", "2024-09-13T14:30:40.561Z").
parent(docs_30, docs_9).

% docs_31
field(docs_31, "title", "Denied operations").
field(docs_31, "cardType", "base/cardTypes/page").
field(docs_31, "workflowState", "Draft").
field(docs_31, "rank", "0|s").
field(docs_31, "lastUpdated", "2024-09-10T19:02:03.651Z").
parent(docs_31, docs_9).

% docs_32
field(docs_32, "title", "Automated policy checks").
field(docs_32, "cardType", "base/cardTypes/page").
field(docs_32, "workflowState", "Draft").
field(docs_32, "rank", "0|z").
field(docs_32, "lastUpdated", "2024-11-05T14:56:12.411Z").
link(docs_32, docs_4nd9wctm, "base/linkTypes/relatesTo").
parent(docs_32, docs_9).

% docs_33
field(docs_33, "title", "Query language").
field(docs_33, "cardType", "base/cardTypes/page").
field(docs_33, "workflowState", "Draft").
field(docs_33, "rank", "0|a").
field(docs_33, "lastUpdated", "2024-09-11T08:03:46.451Z").
parent(docs_33, docs_9).

% docs_4
field(docs_4, "title", "Using the Cyberismo app").
field(docs_4, "cardType", "base/cardTypes/page").
field(docs_4, "workflowState", "Ready").
field(docs_4, "rank", "0|i").
field(docs_4, "lastUpdated", "2024-11-17T16:42:51.511Z").
field(docs_4, "lastTransitioned", "2024-10-21T10:44:25.061Z").

% docs_4nd9wctm
field(docs_4nd9wctm, "title", "Notifications").
field(docs_4nd9wctm, "cardType", "base/cardTypes/page").
field(docs_4nd9wctm, "workflowState", "Draft").
field(docs_4nd9wctm, "rank", "0|zn").
field(docs_4nd9wctm, "lastUpdated", "2024-11-05T14:56:39.513Z").
parent(docs_4nd9wctm, docs_9).

% docs_5
field(docs_5, "title", "Exporting a static documentation site").
field(docs_5, "cardType", "base/cardTypes/page").
field(docs_5, "workflowState", "Ready").
field(docs_5, "rank", "0|j").
field(docs_5, "lastUpdated", "2024-11-17T15:05:39.209Z").
field(docs_5, "lastTransitioned", "2024-10-21T10:44:28.014Z").

% docs_6
field(docs_6, "title", "Developing Cyberismo modules").
field(docs_6, "cardType", "base/cardTypes/page").
field(docs_6, "workflowState", "Draft").
field(docs_6, "rank", "0|k").
field(docs_6, "lastUpdated", "2024-11-15T16:39:51.713Z").

% docs_7
field(docs_7, "title", "Creating a new project").
field(docs_7, "cardType", "base/cardTypes/page").
field(docs_7, "workflowState", "Ready").
field(docs_7, "rank", "0|a").
field(docs_7, "lastUpdated", "2025-01-14T13:14:20.377Z").
field(docs_7, "lastTransitioned", "2024-10-21T10:44:12.554Z").
parent(docs_7, docs_2).

% docs_7n7gqu93
field(docs_7n7gqu93, "title", "Templates").
field(docs_7n7gqu93, "cardType", "base/cardTypes/page").
field(docs_7n7gqu93, "workflowState", "Draft").
field(docs_7n7gqu93, "rank", "0|aaaaag").
field(docs_7n7gqu93, "lastUpdated", "2024-11-18T07:47:32.894Z").
parent(docs_7n7gqu93, docs_6).

% docs_8
field(docs_8, "title", "Naming conventions").
field(docs_8, "cardType", "base/cardTypes/page").
field(docs_8, "workflowState", "Draft").
field(docs_8, "rank", "0|an").
field(docs_8, "lastUpdated", "2025-01-15T15:25:29.111Z").
parent(docs_8, docs_6).

% docs_9
field(docs_9, "title", "Queries and reasoning").
field(docs_9, "cardType", "base/cardTypes/page").
field(docs_9, "workflowState", "Draft").
field(docs_9, "rank", "0|ag").
field(docs_9, "lastUpdated", "2024-11-05T19:31:53.910Z").
parent(docs_9, docs_6).

% docs_i5v1ydlh
field(docs_i5v1ydlh, "title", "Create cards macro").
field(docs_i5v1ydlh, "cardType", "base/cardTypes/page").
field(docs_i5v1ydlh, "workflowState", "Draft").
field(docs_i5v1ydlh, "rank", "0|c").
field(docs_i5v1ydlh, "lastUpdated", "2025-01-20T12:55:12.887Z").
parent(docs_i5v1ydlh, docs_4).

% docs_is0qe6qb
field(docs_is0qe6qb, "title", "Definition of Done").
field(docs_is0qe6qb, "cardType", "base/cardTypes/page").
field(docs_is0qe6qb, "workflowState", "Draft").
field(docs_is0qe6qb, "rank", "0|b").
field(docs_is0qe6qb, "lastUpdated", "2024-08-01T14:25:19.240Z").
parent(docs_is0qe6qb, docs_zmn3e3tq).

% docs_iv4h2usw
field(docs_iv4h2usw, "title", "Editing a card").
field(docs_iv4h2usw, "cardType", "base/cardTypes/page").
field(docs_iv4h2usw, "workflowState", "Ready").
field(docs_iv4h2usw, "rank", "0|b").
field(docs_iv4h2usw, "lastUpdated", "2024-11-17T15:58:12.092Z").
field(docs_iv4h2usw, "lastTransitioned", "2024-10-21T10:44:15.793Z").
parent(docs_iv4h2usw, docs_2).

% docs_qp3vhh4t
field(docs_qp3vhh4t, "title", "Link types").
field(docs_qp3vhh4t, "cardType", "base/cardTypes/page").
field(docs_qp3vhh4t, "workflowState", "Draft").
field(docs_qp3vhh4t, "rank", "0|aaaaad").
field(docs_qp3vhh4t, "lastUpdated", "2024-11-15T17:05:06.148Z").
parent(docs_qp3vhh4t, docs_6).

% docs_r0brt7n1
field(docs_r0brt7n1, "title", "Report macro").
field(docs_r0brt7n1, "cardType", "base/cardTypes/page").
field(docs_r0brt7n1, "workflowState", "Draft").
field(docs_r0brt7n1, "rank", "0|d").
field(docs_r0brt7n1, "lastUpdated", "2025-01-21T07:53:48.691Z").
parent(docs_r0brt7n1, docs_4).

% docs_x6k819z6
field(docs_x6k819z6, "title", "Authoring card content").
field(docs_x6k819z6, "cardType", "base/cardTypes/page").
field(docs_x6k819z6, "workflowState", "Draft").
field(docs_x6k819z6, "rank", "0|b").
field(docs_x6k819z6, "lastUpdated", "2024-11-17T16:10:01.656Z").
parent(docs_x6k819z6, docs_4).

% docs_x9fat7ty
field(docs_x9fat7ty, "title", "Change the card status").
field(docs_x9fat7ty, "cardType", "base/cardTypes/page").
field(docs_x9fat7ty, "workflowState", "Ready").
field(docs_x9fat7ty, "rank", "0|c").
field(docs_x9fat7ty, "lastUpdated", "2024-11-17T15:07:15.937Z").
field(docs_x9fat7ty, "lastTransitioned", "2024-10-21T10:44:18.692Z").
parent(docs_x9fat7ty, docs_2).

% docs_zmn3e3tq
field(docs_zmn3e3tq, "title", "Developing Cyberismo application").
field(docs_zmn3e3tq, "cardType", "base/cardTypes/page").
field(docs_zmn3e3tq, "workflowState", "Draft").
field(docs_zmn3e3tq, "rank", "0|kn").
field(docs_zmn3e3tq, "lastUpdated", "2024-12-04T10:39:49.342Z").


% /home/samu/projects/cyberismo-docs/.calc/resources
cardType("base/cardTypes/controlledDocument").
field("base/cardTypes/controlledDocument", "workflow", "base/workflows/controlledDocument").
customField("base/cardTypes/controlledDocument", "base/fieldTypes/owner").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/owner"), "displayName", "Owner").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/owner"), "isEditable", true).
alwaysVisibleField("base/cardTypes/controlledDocument", "base/fieldTypes/owner").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/owner"), "index", 1).
customField("base/cardTypes/controlledDocument", "base/fieldTypes/informationClassification").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/informationClassification"), "displayName", "Information classification").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/informationClassification"), "isEditable", true).
alwaysVisibleField("base/cardTypes/controlledDocument", "base/fieldTypes/informationClassification").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/informationClassification"), "index", 2).
customField("base/cardTypes/controlledDocument", "base/fieldTypes/approver").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/approver"), "displayName", "Approver").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/approver"), "isEditable", true).
alwaysVisibleField("base/cardTypes/controlledDocument", "base/fieldTypes/approver").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/approver"), "index", 3).
customField("base/cardTypes/controlledDocument", "base/fieldTypes/approvalDate").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/approvalDate"), "displayName", "Approval date").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/approvalDate"), "isEditable", true).
alwaysVisibleField("base/cardTypes/controlledDocument", "base/fieldTypes/approvalDate").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/approvalDate"), "index", 4).
customField("base/cardTypes/controlledDocument", "base/fieldTypes/reviewPeriod").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/reviewPeriod"), "displayName", "Review period (days)").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/reviewPeriod"), "isEditable", true).
optionallyVisibleField("base/cardTypes/controlledDocument", "base/fieldTypes/reviewPeriod").
field(("base/cardTypes/controlledDocument", "base/fieldTypes/reviewPeriod"), "index", 5).

cardType("base/cardTypes/decision").
field("base/cardTypes/decision", "workflow", "base/workflows/decision").
customField("base/cardTypes/decision", "base/fieldTypes/owner").
field(("base/cardTypes/decision", "base/fieldTypes/owner"), "displayName", "Owner").
field(("base/cardTypes/decision", "base/fieldTypes/owner"), "isEditable", true).
alwaysVisibleField("base/cardTypes/decision", "base/fieldTypes/owner").
field(("base/cardTypes/decision", "base/fieldTypes/owner"), "index", 1).
customField("base/cardTypes/decision", "base/fieldTypes/informationClassification").
field(("base/cardTypes/decision", "base/fieldTypes/informationClassification"), "displayName", "Information classification").
field(("base/cardTypes/decision", "base/fieldTypes/informationClassification"), "isEditable", true).
alwaysVisibleField("base/cardTypes/decision", "base/fieldTypes/informationClassification").
field(("base/cardTypes/decision", "base/fieldTypes/informationClassification"), "index", 2).
customField("base/cardTypes/decision", "base/fieldTypes/decisionDate").
field(("base/cardTypes/decision", "base/fieldTypes/decisionDate"), "displayName", "Decision date").
field(("base/cardTypes/decision", "base/fieldTypes/decisionDate"), "isEditable", true).
alwaysVisibleField("base/cardTypes/decision", "base/fieldTypes/decisionDate").
field(("base/cardTypes/decision", "base/fieldTypes/decisionDate"), "index", 3).

cardType("base/cardTypes/page").
field("base/cardTypes/page", "workflow", "base/workflows/page").
customField("base/cardTypes/page", "base/fieldTypes/owner").
field(("base/cardTypes/page", "base/fieldTypes/owner"), "displayName", "Owner").
field(("base/cardTypes/page", "base/fieldTypes/owner"), "isEditable", true).
alwaysVisibleField("base/cardTypes/page", "base/fieldTypes/owner").
field(("base/cardTypes/page", "base/fieldTypes/owner"), "index", 1).
customField("base/cardTypes/page", "base/fieldTypes/informationClassification").
field(("base/cardTypes/page", "base/fieldTypes/informationClassification"), "displayName", "Information classification").
field(("base/cardTypes/page", "base/fieldTypes/informationClassification"), "isEditable", true).
alwaysVisibleField("base/cardTypes/page", "base/fieldTypes/informationClassification").
field(("base/cardTypes/page", "base/fieldTypes/informationClassification"), "index", 2).

cardType("base/cardTypes/recurringTask").
field("base/cardTypes/recurringTask", "workflow", "base/workflows/recurringTask").
customField("base/cardTypes/recurringTask", "base/fieldTypes/owner").
field(("base/cardTypes/recurringTask", "base/fieldTypes/owner"), "displayName", "Owner").
field(("base/cardTypes/recurringTask", "base/fieldTypes/owner"), "isEditable", true).
alwaysVisibleField("base/cardTypes/recurringTask", "base/fieldTypes/owner").
field(("base/cardTypes/recurringTask", "base/fieldTypes/owner"), "index", 1).
customField("base/cardTypes/recurringTask", "base/fieldTypes/informationClassification").
field(("base/cardTypes/recurringTask", "base/fieldTypes/informationClassification"), "displayName", "Information classification").
field(("base/cardTypes/recurringTask", "base/fieldTypes/informationClassification"), "isEditable", true).
alwaysVisibleField("base/cardTypes/recurringTask", "base/fieldTypes/informationClassification").
field(("base/cardTypes/recurringTask", "base/fieldTypes/informationClassification"), "index", 2).
customField("base/cardTypes/recurringTask", "base/fieldTypes/reviewPeriod").
field(("base/cardTypes/recurringTask", "base/fieldTypes/reviewPeriod"), "displayName", "Review period (days)").
field(("base/cardTypes/recurringTask", "base/fieldTypes/reviewPeriod"), "isEditable", false).
optionallyVisibleField("base/cardTypes/recurringTask", "base/fieldTypes/reviewPeriod").
field(("base/cardTypes/recurringTask", "base/fieldTypes/reviewPeriod"), "index", 3).

cardType("base/cardTypes/task").
field("base/cardTypes/task", "workflow", "base/workflows/task").
customField("base/cardTypes/task", "base/fieldTypes/owner").
field(("base/cardTypes/task", "base/fieldTypes/owner"), "displayName", "Owner").
field(("base/cardTypes/task", "base/fieldTypes/owner"), "isEditable", true).
alwaysVisibleField("base/cardTypes/task", "base/fieldTypes/owner").
field(("base/cardTypes/task", "base/fieldTypes/owner"), "index", 1).
customField("base/cardTypes/task", "base/fieldTypes/informationClassification").
field(("base/cardTypes/task", "base/fieldTypes/informationClassification"), "displayName", "Information classification").
field(("base/cardTypes/task", "base/fieldTypes/informationClassification"), "isEditable", true).
alwaysVisibleField("base/cardTypes/task", "base/fieldTypes/informationClassification").
field(("base/cardTypes/task", "base/fieldTypes/informationClassification"), "index", 2).
customField("base/cardTypes/task", "base/fieldTypes/dueDate").
field(("base/cardTypes/task", "base/fieldTypes/dueDate"), "displayName", "Due date").
field(("base/cardTypes/task", "base/fieldTypes/dueDate"), "isEditable", true).
alwaysVisibleField("base/cardTypes/task", "base/fieldTypes/dueDate").
field(("base/cardTypes/task", "base/fieldTypes/dueDate"), "index", 3).

fieldType("base/fieldTypes/approvalDate").
field("base/fieldTypes/approvalDate", "displayName", "Approval date").
field("base/fieldTypes/approvalDate", "dataType", "date").

fieldType("base/fieldTypes/approver").
field("base/fieldTypes/approver", "displayName", "Approver").
field("base/fieldTypes/approver", "dataType", "person").

fieldType("base/fieldTypes/decisionDate").
field("base/fieldTypes/decisionDate", "displayName", "Decision date").
field("base/fieldTypes/decisionDate", "dataType", "date").

fieldType("base/fieldTypes/dueDate").
field("base/fieldTypes/dueDate", "displayName", "Due date").
field("base/fieldTypes/dueDate", "dataType", "date").

fieldType("base/fieldTypes/informationClassification").
field("base/fieldTypes/informationClassification", "displayName", "Information classification").
field("base/fieldTypes/informationClassification", "dataType", "enum").
enumValue("base/fieldTypes/informationClassification", "confidential").
field(("base/fieldTypes/informationClassification", "confidential"), "index", 1).
field(("base/fieldTypes/informationClassification", "confidential"), "enumDisplayValue", "Confidential").
enumValue("base/fieldTypes/informationClassification", "internal").
field(("base/fieldTypes/informationClassification", "internal"), "index", 2).
field(("base/fieldTypes/informationClassification", "internal"), "enumDisplayValue", "Internal").
enumValue("base/fieldTypes/informationClassification", "public").
field(("base/fieldTypes/informationClassification", "public"), "index", 3).
field(("base/fieldTypes/informationClassification", "public"), "enumDisplayValue", "Public").

fieldType("base/fieldTypes/meetingDate").
field("base/fieldTypes/meetingDate", "displayName", "Meeting date").
field("base/fieldTypes/meetingDate", "dataType", "date").

fieldType("base/fieldTypes/owner").
field("base/fieldTypes/owner", "displayName", "Owner").
field("base/fieldTypes/owner", "dataType", "person").

fieldType("base/fieldTypes/progress").
field("base/fieldTypes/progress", "displayName", "Progress").
field("base/fieldTypes/progress", "fieldDescription", "A progress metric").
field("base/fieldTypes/progress", "dataType", "integer").

fieldType("base/fieldTypes/reviewPeriod").
field("base/fieldTypes/reviewPeriod", "displayName", "Review period (days)").
field("base/fieldTypes/reviewPeriod", "dataType", "integer").

linkType("base/linkTypes/blocks").
field("base/linkTypes/blocks", "outboundDisplayName", "blocks").
field("base/linkTypes/blocks", "inboundDisplayName", "is blocked by").
field("base/linkTypes/blocks", "enableLinkDescription", false).

linkType("base/linkTypes/relatesTo").
field("base/linkTypes/relatesTo", "outboundDisplayName", "relates to").
field("base/linkTypes/relatesTo", "inboundDisplayName", "is related to").
field("base/linkTypes/relatesTo", "enableLinkDescription", false).

linkType("base/linkTypes/supersedes").
field("base/linkTypes/supersedes", "outboundDisplayName", "supersedes").
field("base/linkTypes/supersedes", "inboundDisplayName", "is superseded by").
field("base/linkTypes/supersedes", "enableLinkDescription", false).
linkSourceCardType("base/linkTypes/supersedes", "base/cardTypes/decision").
linkDestinationCardType("base/linkTypes/supersedes", "base/cardTypes/decision").

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

workflow("base/workflows/decision").
workflowState("base/workflows/decision", "Draft", "initial").
workflowState("base/workflows/decision", "Approved", "closed").
workflowState("base/workflows/decision", "Deprecated", "closed").
workflowTransition("base/workflows/decision", "Create", "", "Draft").
workflowTransition("base/workflows/decision", "Approve", "Draft", "Approved").
workflowTransition("base/workflows/decision", "Archive", "*", "Deprecated").
workflowTransition("base/workflows/decision", "Reopen", "*", "Draft").

workflow("base/workflows/page").
workflowState("base/workflows/page", "Draft", "initial").
workflowState("base/workflows/page", "Ready", "closed").
workflowState("base/workflows/page", "Deprecated", "closed").
workflowTransition("base/workflows/page", "Create", "", "Draft").
workflowTransition("base/workflows/page", "Content ready", "Draft", "Ready").
workflowTransition("base/workflows/page", "Archive", "*", "Deprecated").
workflowTransition("base/workflows/page", "Reopen", "*", "Draft").

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





select("title";"workflowStateCategory";"base/fieldTypes/progress";"rank";"cardType").
result(Card) :- card(Card), not parent(Card, _), not hiddenInTreeView(Card).
childResult(Parent, Card, "children") :- card(Card), parent(Card, Parent), not hiddenInTreeView(Card).
order(Level, "children", 1, "rank", "ASC") :-
    level(Level).

