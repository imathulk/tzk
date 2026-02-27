# AI-Powered Report Page Blueprint (Dark SaaS Dashboard)

## 1) Page Structure Breakdown (Desktop-first)

### Global shell
- **Left Sidebar Navigation (fixed)**
  - Width: `240px` expanded / `80px` collapsed.
  - Sections: Dashboard, Reports, Templates, Automations, Integrations, Settings.
  - Report context quick switcher (account/workspace + date range shortcut).
- **Top Header (sticky within content area)**
  - Left: report title, editable inline, report date range.
  - Middle: template linkage badge + status (“Linked to Template: Q1 Growth”).
  - Right: primary actions (`Share`, `Export`, `Edit Layout`, overflow menu).
- **Main Report Canvas (scrollable)**
  - 12-column grid, `gap-paddings.organism` spacing.
  - Cards are arranged in modular rows with drag/reorder in edit mode.
  - Optional right utility rail (AI Assistant pinned panel on large screens).

### Content zones inside report canvas
1. **KPI band** (top row): quick metrics cards.
2. **Performance section**: trend charts + breakdown graphs.
3. **AI insights section**: generated analysis with confidence and suggested actions.
4. **Client Note section**: internal/client-facing communication tied to metrics.
5. **Appendix modules**: table widgets, channel splits, attribution notes.

---

## 2) Component Hierarchy

```text
ReportPage
├── AppShell
│   ├── SidebarNav
│   │   ├── NavGroup
│   │   └── WorkspaceSwitcher
│   └── ContentArea
│       ├── ReportHeader
│       │   ├── EditableReportTitle
│       │   ├── TemplateIndicatorBadge
│       │   ├── DateRangeSelector
│       │   └── HeaderActions
│       │       ├── ShareButton
│       │       ├── ExportButton
│       │       └── EditLayoutToggle
│       ├── ReportCanvas
│       │   ├── KPISection
│       │   │   └── KPICard[]
│       │   ├── ChartSection
│       │   │   ├── PerformanceChartCard
│       │   │   └── BreakdownChartCard
│       │   ├── AIInsightsCard
│       │   ├── ClientNotesCard
│       │   └── CustomModuleSlot[]
│       └── AIAssistantPanel
│           ├── PromptInput
│           ├── SuggestionChips
│           └── ChatThread
└── GlobalOverlays
    ├── ShareDropdown
    │   ├── ShareViaLinkItem
    │   ├── DownloadPdfItem
    │   └── SmartShareItem
    └── SmartShareModal
        ├── FrequencySelector
        ├── CustomDaysPicker
        ├── TimeSelector
        ├── RecipientsInput
        └── SaveAutomationAction
```

---

## 3) Key UX Modules

## 3.1 Template indicator badge
- **Placement:** header next to report title.
- **States:**
  - Linked (default): purple-toned badge with template name.
  - Unlinked: neutral outlined badge + CTA “Link to template”.
  - Broken link: warning style if template deleted/missing fields.
- **Behavior:** click opens side sheet with template metadata, sync options, and “detach report”.

## 3.2 Share button behavior
- **Trigger:** Header `Share` button.
- **Dropdown items:**
  1. **Share via Link** (copy URL / permission level).
  2. **Download as PDF** (current view or full report).
  3. **Smart Share (automation)** (opens settings modal).

### Smart Share settings (modal)
- **Frequency:** Daily / Weekly / Monthly / Custom days.
- **Custom days:** weekday picker (Mon–Sun) or day-of-month selector.
- **Time selector:** timezone-aware send time.
- **Recipients:** multi-email token input with validation + optional message.
- **Preview:** next 3 scheduled sends + sample email subject line.
- **Controls:** Save, Save & Send Test, Cancel.

## 3.3 AI assistant area
- **Location:** right rail panel or floating dock (resizable).
- **Modes:**
  - “Generate report from scratch” (guided prompt + objective + channels + timeframe).
  - “Suggest insights” based on visible report data.
  - “Summarize for client” to produce client-friendly narrative.
- **UX details:**
  - prompt textarea with slash commands (`/insight`, `/summary`, `/anomaly`).
  - suggestion chips from recent data anomalies.
  - one-click “Insert into AI Insights card” action.

---

## 4) Reusable Card Design Contract

Every report card (KPI/Chart/AI/Notes) should implement a shared interface:

- **Base anatomy**
  - Card header: title, optional subtitle, context menu.
  - Card body: visualization or content.
  - Card footer: last updated + source + quick actions.
- **Interactive states**
  - Default
  - Hover (elevated shadow + border accent)
  - Focused (keyboard focus ring)
  - Edit mode (drag handle + inline controls)
  - Loading skeleton
  - Empty state with guidance CTA
  - Error state with retry
- **Edit mode controls**
  - resize (S/M/L or grid span)
  - duplicate
  - replace module
  - remove module

---

## 5) Suggested UI States (per component)

### KPI summary card
- **Default:** metric, delta %, period comparison, micro sparkline.
- **Hover:** highlight metric trend + reveal quick filter icon.
- **Loading:** shimmer line + number placeholders.
- **Empty:** “No data for selected period” + “Adjust date range”.
- **Edit:** choose metric binding, attribution model, currency format.

### Chart & performance graph card
- **Default:** line/bar/area chart with legend and channel filters.
- **Hover:** data point tooltip + crosshair.
- **Loading:** chart skeleton grid + animated placeholder path.
- **Empty:** channel not connected / zero events.
- **Edit:** chart type switcher, metric axis remap, compare period toggle.

### AI insights card
- **Default:** 2–4 generated insights with confidence tags.
- **Hover:** reveal “expand reasoning” and “regenerate”.
- **Loading:** conversational skeleton blocks.
- **Empty:** “Generate insights” CTA + suggestions.
- **Edit:** tone selection (executive, analytical, client-safe).

### Client note section
- **Default:** rich-text note thread tied to timestamped metrics.
- **Hover:** quick actions (mention, pin, resolve).
- **Loading:** message skeleton rows.
- **Empty:** “Add a note for your team or client”.
- **Edit:** markdown/rich controls, @mentions, visibility switch (internal/client).

---

## 6) Dark Theme Token Mapping (from provided system)

### Surfaces and text
- App background: `primitives.neutral.1100`.
- Secondary surfaces/cards: `primitives.neutral.1000`.
- Elevated cards/popups: `primitives.neutral.900`.
- Primary text: `primitives.neutral.100`.
- Secondary text: `primitives.neutral.400`.
- Muted metadata: `primitives.neutral.500`.

### Brand/action colors
- Primary CTA: `colors.brand.default`.
- CTA hover: `colors.brand.hover`.
- Soft selected backgrounds: `colors.brand.light` with low alpha.
- AI CTA (Generate/Ask AI): linear gradient `#8426ff -> #4234df`.

### Spacing, radii, and effects
- Card padding: `gap-paddings.organism` (24).
- Internal row gaps: `gap-paddings.molecule` (12).
- Corner radius cards/modals: `radius.page` (16) for major containers, `radius.organism` (8) for standard cards.
- Shadows:
  - cards: `effect.widget`
  - dropdown/modal: `effect.popup.bottom`
  - focus: `effect.focused`

### Typography application
- Page/report title: `h1 bold`.
- Section titles: `h2 bold`.
- Body copy & controls: `text regular` / `interface regular`.
- Metadata (timestamps, source labels): `subtext regular`.

---

## 7) High-level React Component Structure

```tsx
// app/reports/[reportId]/page.tsx
export default function ReportPage() {
  return (
    <AppShell>
      <SidebarNav />

      <main className="report-content">
        <ReportHeader
          title="Performance Report"
          template={{ linked: true, name: 'Q1 Growth Template' }}
          actions={{ share: true, export: true, editLayout: true }}
        />

        <ReportCanvas>
          <KPISection>
            <KPICard metric="ROAS" />
            <KPICard metric="Spend" />
            <KPICard metric="Revenue" />
            <KPICard metric="CPA" />
          </KPISection>

          <ChartSection>
            <PerformanceChartCard />
            <BreakdownChartCard />
          </ChartSection>

          <AIInsightsCard />
          <ClientNotesCard />
        </ReportCanvas>
      </main>

      <AIAssistantPanel />
      <ShareDropdown />
      <SmartShareModal />
    </AppShell>
  );
}
```

```tsx
// component contracts (pseudo-types)
type ReportCardProps = {
  title: string;
  loading?: boolean;
  empty?: boolean;
  editable?: boolean;
  onEdit?: () => void;
  onRemove?: () => void;
};

type SmartShareSettings = {
  frequency: 'daily' | 'weekly' | 'monthly' | 'custom';
  customDays?: number[]; // day index or month-day based on mode
  sendTime: string; // HH:mm
  timezone: string;
  recipients: string[];
};
```

---

## 8) UX Decisions and Rationale

- **Desktop-first + left nav + sticky header** keeps report context stable while exploring long scroll analytics.
- **Modular card system** scales as new analytics blocks are added without redesigning the page.
- **Template badge in header** improves transparency for teams using standardized reporting.
- **Share dropdown with Smart Share** supports both one-off sharing and operational automation in one entry point.
- **Client Notes embedded in the report** keeps communication near data, reducing context switching.
- **AI assistant + AI insights card pairing** allows generation in one place and controlled insertion into report modules.
- **State-complete card design** (hover/edit/loading/empty/error) ensures production readiness and design-system consistency.
- **Token-driven dark theme** ensures visual cohesion, lower eye strain, and future theming flexibility.

