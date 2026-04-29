USE `megam_live`;

-- 1. Insert Product Suites
INSERT INTO `product_suites` (`id`, `title`, `productType`, `maturity`, `shortDescription`, `fullDescription`, `iconName`, `externalLink`) VALUES
('artwork-today', 'Artwork Today', 'SaaS Platform', 'Production', 'Regulated Artwork & Labeling Platform for Microsoft 365', 'Artwork Today is a regulated artwork and labeling platform delivered as a SaaS solution and deployed directly into your Microsoft 365 environment. It centralizes artwork intake, versioning, reviews, and approvals while preserving your organization’s security, permissions, and compliance boundaries. Built for regulated industries, the platform enforces structured workflows and immutable audit trails.', 'Shield', 'https://www.artwork.today'),
('project-tracker', 'PlanWise AI', 'M365 Solution', 'Production', 'AI-powered project planning and execution solution for Microsoft 365', 'PlanWise AI is an AI-powered project planning and execution solution built on Microsoft 365 that transforms how teams initiate and manage projects. Simply define a project goal, and PlanWise AI intelligently generates recommended tasks, timelines, and dependencies, accelerating project setup and ensuring structured execution from day one. It provides a centralized, real-time view of projects, ownership, risks, and progress across the organization, with built-in workflows, dashboards, and automation designed for leadership visibility and operational control.', 'BarChart3', NULL),
('megam-pulse', 'Megam Pulse', 'Digital Workplace Solution', 'Early Production', 'Organization’s Pulse on Knowledge, Communication, and Context', 'Megam Pulse is an intelligent digital workplace designed to reflect the real-time pulse of your organization bringing together communication, knowledge, and context into a unified Microsoft 365 experience. Built as a modern intranet foundation, it enables employees to find information faster and stay aligned with organizational updates.', 'Layout', NULL),
('material-master', 'Product & Packaging Hub', 'PRODUCT DATA SOLUTION', 'Production', 'Governed product and packaging data solution for Microsoft 365 with compliant SAP synchronization', 'The Product & Packaging Hub is a Microsoft 365–based solution that orchestrates cross-functional product data creation before it reaches SAP. Regulatory, Packaging, Quality, Finance, and Operations contribute to a structured, role-driven workflow that captures all required product and BOM data. Each step is governed by approvals, electronic signatures, and complete audit trails, ensuring compliance and accountability. Once validated and signed off, data is seamlessly synchronized into SAP, establishing a trusted and compliant system of record.', 'Layers', NULL),
('print-ops', 'Print Order Management', 'Workflow Solution', 'Production', 'Controlled Print Intake & Execution for Regulated Environments', 'Print Order Management is a structured workflow solution designed to govern print intake, approvals, and execution in regulated manufacturing and packaging environments. By enforcing standardized intake processes and approval routing, it ensures compliance across the entire print lifecycle.', 'RefreshCw', NULL);

-- 2. Insert Suite Features
INSERT INTO `suite_features` (`suite_id`, `feature`) VALUES
('artwork-today', 'Artwork intake and lifecycle management'),
('artwork-today', 'Version control with full approval history'),
('artwork-today', 'Role-based reviews and sign-offs'),
('artwork-today', 'Automated notifications and due dates'),
('artwork-today', 'Audit-ready activity logs within M365'),
('project-tracker', 'AI-generated project plans from business goals'),
('project-tracker', 'Task, dependency, and timeline orchestration'),
('project-tracker', 'Built-in risk, issue, and change tracking'),
('project-tracker', 'Role-based dashboards for PMOs and leadership'),
('project-tracker', 'Teams and Outlook-integrated notifications'),
('project-tracker', 'Workflow-driven execution and approvals'),
('megam-pulse', 'Branded news and communication hubs'),
('megam-pulse', 'Departmental workspaces and knowledge libraries'),
('megam-pulse', 'Enterprise search powered by Microsoft Graph'),
('megam-pulse', 'Copilot-assisted content discovery and retrieval'),
('megam-pulse', 'Mobile-first, responsive intranet design'),
('material-master', 'Cross-functional data contribution workflows'),
('material-master', 'Role-based validations and field-level controls'),
('material-master', 'Configurable multi-step approvals'),
('material-master', 'Electronic signatures (21 CFR Part 11 ready)'),
('material-master', 'End-to-end audit trails and traceability'),
('material-master', 'Seamless SAP material & BOM synchronization'),
('print-ops', 'Centralized print request intake'),
('print-ops', 'Approval routing with audit visibility'),
('print-ops', 'Vendor coordination and order tracking'),
('print-ops', 'Status-driven notifications and escalations'),
('print-ops', 'Secure document storage and lifecycle control');

-- 3. Insert Suite Benefits
INSERT INTO `suite_benefits` (`suite_id`, `benefit`) VALUES
('artwork-today', 'Faster artwork approval cycles'),
('artwork-today', 'Improved compliance and traceability'),
('artwork-today', 'Reduced rework and approval bottlenecks'),
('artwork-today', 'Single source of truth for artwork data'),
('project-tracker', 'Accelerates project setup with AI-driven planning'),
('project-tracker', 'Improves execution consistency across teams'),
('project-tracker', 'Reduces delays through better dependency management'),
('project-tracker', 'Enhances visibility for leadership and PMOs'),
('project-tracker', 'Eliminates reliance on fragmented tools like Planner or Smartsheet'),
('project-tracker', 'Drives structured, scalable project delivery'),
('megam-pulse', 'Improved internal communication effectiveness'),
('megam-pulse', 'Faster access to organizational knowledge'),
('megam-pulse', 'Reduced time spent searching for information'),
('megam-pulse', 'Higher employee adoption and engagement'),
('material-master', 'Eliminates spreadsheet-driven product setup'),
('material-master', 'Improves data accuracy before SAP entry'),
('material-master', 'Ensures compliance with full auditability'),
('material-master', 'Reduces rework and SAP data corrections'),
('material-master', 'Drives cross-functional accountability'),
('material-master', 'Accelerates product launch readiness'),
('print-ops', 'Reduced manual print coordination'),
('print-ops', 'Faster print turnaround times'),
('print-ops', 'Improved vendor transparency'),
('print-ops', 'Fewer execution errors'),
('print-ops', 'Stronger compliance documentation');

-- 4. Insert Suite Badges
INSERT INTO `suite_badges` (`suite_id`, `badge`) VALUES
('artwork-today', 'Compliance-Aligned'),
('artwork-today', 'M365 Native'),
('artwork-today', 'Production-Grade'),
('project-tracker', 'M365 Native'),
('project-tracker', 'AI-Powered'),
('project-tracker', 'Copilot-Ready'),
('project-tracker', 'Production-Grade'),
('megam-pulse', 'M365 Native'),
('megam-pulse', 'Copilot-Ready'),
('material-master', 'Compliance-Aligned'),
('material-master', 'M365 Native'),
('material-master', 'ERP Integrated'),
('material-master', 'Production-Grade'),
('print-ops', 'Compliance-Aligned'),
('print-ops', 'M365 Native'),
('print-ops', 'ERP Integrated'),
('print-ops', 'Production-Grade');

-- 5. Insert Services
INSERT INTO `services` (`id`, `title`, `description`, `iconName`) VALUES
('sharepoint', 'SharePoint Online Architecture', 'Designing modern SharePoint architectures for intranets, process automation, document management, and governed collaboration aligned with enterprise security and compliance standards.', 'AppWindow'),
('power-automate', 'Power Automate Workflow Automation', 'Designing and governing Power Automate workflows to streamline approvals, integrations, and operational processes across Microsoft 365 without compromising control or auditability.', 'RefreshCw'),
('power-bi', 'Power BI Data Engineering', 'Delivering Power BI dashboards and reporting models that transform operational and compliance data into actionable insights for leadership and business teams.', 'Database'),
('teams', 'Microsoft Teams Governance', 'Extending Microsoft Teams into a secure collaboration and application hub using custom apps, notifications, and integrated workflows aligned to enterprise usage patterns.', 'MessageSquare'),
('azure', 'Azure Hybrid Services', 'Leveraging Azure services to support secure integrations, backend services, and scalable architectures that extend Microsoft 365 beyond its core capabilities.', 'Shield'),
('copilot', 'Copilot Studio & AI Enablement', 'Designing permission-aware Copilot experiences and AI-enabled workflows grounded in Microsoft Graph, Copilot Studio, and governed enterprise data sources.', 'Brain');

-- 6. Insert Case Studies
INSERT INTO `case_studies` (`id`, `clientIndustry`, `title`, `outcome`) VALUES
('reg-pharma', 'Regulated Healthcare', 'Traceable Asset Approvals for Global Pharma', 'Implemented a zero-error labeling workflow for a major healthcare provider.'),
('private-equity', 'Financial Services', 'AI-Powered Investor Reporting Automation', 'Automated the extraction of data from 500+ unstructured reports monthly.');

-- 7. Insert Case Study Metrics
INSERT INTO `case_study_metrics` (`case_study_id`, `label`, `value`, `suffix`) VALUES
('reg-pharma', 'Compliance', '100', '%'),
('reg-pharma', 'Approval Time', '60', '% Faster'),
('private-equity', 'Manual Effort', '85', '% Less'),
('private-equity', 'Accuracy', '99.8', '%');

-- 8. Insert Release Events (From Firebase Dump)
INSERT INTO `release_events` (`id`, `monthYear`, `product`, `feature`, `status`, `source`) VALUES
(1, 'MAR 2025', 'Artwork Today', 'GTIN-driven Item Master with SAP OData Sync', 'PRODUCTION', 'SRC::SAP_CONNECTOR'),
(2, 'MAR 2025', 'Copilot Agents', 'Neural Memory Layer for Multi-turn Conversations', 'PRODUCTION', 'SRC::AI_ENGINE_v4'),
(3, 'FEB 2025', 'Project Tracker', 'Portfolio Dashboard with Gantt & Dependency View', 'VALIDATED', 'SRC::M365_GRAPH'),
(4, 'FEB 2025', 'GxP Guard', '21 CFR Part-11 Automated Signature Protocol', 'PRODUCTION', 'SRC::COMPLIANCE_NODE'),
(5, 'JAN 2025', 'Copilot Agents', 'SharePoint-Scoped AI Agent with Permission Inheritance', 'PRODUCTION', 'SRC::NEURAL_ENGINE'),
(6, 'JAN 2025', 'Artwork Today', 'Vendor Handshake v2 with Encrypted OData Tunnel', 'VALIDATED', 'SRC::S4_TUNNEL'),
(7, 'DEC 2024', 'Artwork Today', 'Audit-Ready Approval Logs (GxP Aligned)', 'PRODUCTION', 'SRC::GUARD_NODE'),
(8, 'DEC 2024', 'Sync Layer', 'RFC Refresh Cycle v4.1 Optimization', 'PRODUCTION', 'SRC::S4_CORE'),
(9, 'NOV 2024', 'Megam Pulse', 'Employee Signals & Knowledge Discovery (Graph-Powered)', 'UAT', 'SRC::GRAPH_FABRIC'),
(10, 'OCT 2024', 'Custom Intranets', 'Branded News Hubs with Decentralized Knowledge', 'PILOT', 'SRC::UX_LAYER'),
(11, 'SEP 2024', 'SAP Sync', 'Real-time Material Master Sync Overload Patch', 'PRODUCTION', 'SRC::S4_CORE'),
(12, 'AUG 2024', 'Security Node', 'DLP Policy Scan Complete for Regulated Tenants', 'VALIDATED', 'SRC::NET_SHIELD');
