# Kanakkan

An on-device, sovereign, privacy-first personal financial ledger & salary cycle tracker tailored for Indian professionals.

## Key Capabilities

- **100% On-Device Sovereign Privacy**: Zero telemetry, zero cloud dependencies. No plain-text data leaves your phone.
- **Dynamic Bank Template Engine**: Store bank SMS formats as data, with an interactive tap-to-tag template builder.
- **Automated Ingestion Pipeline**:
  - Intercepts incoming SMS via Android broadcast receiver and inbox backfill scanner.
  - Rejects OTPs and promotional messages.
  - Zero-assumption income: Inbound money is never counted as salary without explicit confirmation.
  - Deduplication via UPI Ref or transaction fingerprint.
  - Automated balance reconciliation detecting unaccounted cash spends.
- **Deterministic Financial Engine**:
  - Integer paise precision arithmetic.
  - Daily Safe-to-Spend pace formula: `(Balance - Bills - Buffer) / Days Left`.
  - "Can I buy it now?" real-time affordability evaluator.
  - Recurring cadence detector (7, 14, 30, 365 days $\pm 3$ days, $\pm 10\%$ fixed, $\pm 25\%$ variable).
  - 50/30/20 budget envelope analytics and Chai Factor micro-spend aggregation (< ₹100).
- **Material 3 UI**: Deep Teal (`#0F766E`), Soft Mint (`#86F2E4`), and Warm Amber theme with Inter typography.
