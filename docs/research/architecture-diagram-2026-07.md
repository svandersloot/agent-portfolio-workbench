# Agent Governance Reference Architecture (Mermaid)

Date: 2026-07-08 · Companion to `enterprise-agent-governance-operating-model-2026-07.md`

Solid arrows = automated or tool-assisted (read-only or dry-run+approval). Dashed arrows = human-owned manual actions. No automated write path exists to any runtime.

```mermaid
flowchart TB
    subgraph intake["Intake & Triage"]
        A["Pain point<br/>chat / Jira / Confluence"] --> B{"Fit triage G1<br/>prompt / automation /<br/>extend / new / not ready"}
        B --> C["Duplicate and reuse check<br/>reuse → improve → merge → reject → new"]
    end

    subgraph workbench["Governance Workbench (Git — record of intent & evidence)"]
        D["Registry of record<br/>owner · backup · status · risk tier<br/>platform · write capability · last review"]
        E["Spec layer<br/>Project Brain · runtime contract<br/>context map · knowledge source plan"]
        F["Evaluation layer<br/>prompt packs · pass/partial/fail<br/>regression evidence"]
        G["Evidence and audit layer<br/>captures · parity checks · publish history<br/>approvals · change log"]
        H["Measurement layer<br/>usage · accepted/edited/rejected<br/>incidents · reuse decisions"]
    end

    subgraph human["Human-Facing Surfaces"]
        I["Confluence / SharePoint<br/>approved published copies"]
        J["Jira / ADO<br/>work tracking only —<br/>never governance authority"]
    end

    subgraph runtimes["Agent Runtimes (ground truth of behavior)"]
        K["Rovo Studio<br/>manual config · no API"]
        L["Copilot Studio<br/>solutions · Git ALM · pipelines"]
        M["Claude / ChatGPT Enterprise<br/>skills · MCP · workspace agents"]
        N["Custom agents<br/>CI/CD native"]
    end

    O(("Human approver<br/>owner · reviewer · steward"))

    C --> D
    D --> E --> F
    F -.->|copy packet + manual save| K
    F -->|native ALM / pipeline gate| L
    F -.->|reviewed settings and skills| M
    F -->|eval-gated CI| N
    K -->|capture + normalize| G
    L -->|solution export / Git sync| G
    M -->|compliance API pulls| G
    N -->|traces & configs| G
    G -->|parity & drift diff| D
    E -->|dry-run then approved publish| I
    J --> A
    K & L & M & N -->|platform analytics| H
    H -->|monthly snapshot| I
    O -.->|approves: pilot · promotion · visibility<br/>ownership · retirement · policy exceptions| D
    O -.->|manual runtime saves| K
```

Reading the diagram: Git holds intent and evidence; runtimes hold behavior; capture plus parity checks bridge the two; every consequential state change routes through the human approver node. Copilot is the one runtime where a supported Git path exists today, so its arrow is solid in both directions.
