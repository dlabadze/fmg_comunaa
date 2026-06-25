# სამეზობლოს — მობილური აპლიკაცია

**ბოლო პროტოტიპის ვერსია:** `v1.6-final` (2026-06-03) — იხ. [`VERSION.md`](VERSION.md) · snapshot: `prototype/index-v1.6-final.html` · სრული ასლი: `prototype-v1.6-final/`

## ფაილები (MAP-ინგით)

| # | ფაილი | დანიშნულება |
|---|-------|-------------|
| 1 | `docs/DEVELOPER_SPEC.md` | **დეველოპერის დოკუმენტი** — API, routes, მოდელები |
| 2 | `data/screen-mapping.json` | **მანქანური MAP** — ეკრან ↔ API ↔ feature |
| 3 | `prototype/index.html` | **ვიზუალი (საკუთარი სტილი)** ★ |
| 4 | `docs/DESIGN_IDENTITY.md` | ვიზუალური კონცეფცია · Archi-სგან განსხვავება |
| 3b | `prototype/archi-format.html` | ძველი Archi-სტილი (არ გამოიყენო) |
| 4 | `docs/VISUAL_REFERENCE.md` | **ფოტო → ეკრანის MAP** |
| 5 | `DESIGN_BRIEF.md` | UX / დიზაინ სისტემა |

## სწრაფი დაწყება

1. დეველოპერი → წაიკითხე `docs/DEVELOPER_SPEC.md`
2. ვიზუალი → გახსენი `prototype/index.html` ბრაუზერში
3. **გარე მომხმარებლისთვის საჯარო ლინკი** → [`SHARE.md`](SHARE.md) (Netlify Drop / GitHub Pages)
4. MAP → `SCR-010` = მთავარი ეკრანი = `GET /dashboard` = tab `home`

## MAP სქემა

```
Feature (F-xxx) → Screen (SCR-xxx) → Route → API → Tab
```

რეფერენსები: [Archi](https://www.palindroma.com/work/archi-mobile-app) · [DwellUP](https://dwellup.io/)
