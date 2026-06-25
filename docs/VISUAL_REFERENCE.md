# ვიზუალური რეფერენსი — Archi სტილი (MAP)

> ფოტოები → ეკრანი (SCR) → პროტოტიპი → დეველოპერი  
> ბრენდი აპში: **სამეზობლოს** (ვიზუალი Archi-ს მიხედვით)

---

## ფოტო → ეკრანის MAP

| # | ფოტო (Archi) | SCR ID | პროტოტიპი `key` | სამეზობლოს ადაპტაცია |
|---|--------------|--------|------------------|----------------------|
| 1 | მენიუ (სრული სია) | SCR-055 | `menu` | იგივე სტრუქტურა, ლოგო სამეზობლოს |
| 2 | მენიუ + სერვისების sheet | SCR-055 + modal | `menu` + `services-sheet` | სერვისების bottom sheet |
| 3 | ქონება (გადახდები) | SCR-080 | `property` | ბინა + გადახდის ბლოკი |
| 4 | პროექტები | SCR-070 | `projects` | კომპლექსი / სიახლეები პროექტებზე |
| 5 | ქარდი (შეთავაზებები) | SCR-060 | `offers` | პარტნიორების ფასდაკლებები |
| 6 | ქარდი — loyalty | SCR-061 | `offers-detail` | ლოიალობის ბარათი (v2) |
| 7 | ხარვეზის დაფიქსირება (empty) | SCR-030 | `service` | სერვისის მოთხოვნების სია |
| 8 | პრობლემის ფორმა | SCR-031 | `service-new` | სრული ფორმა + ფოტო |
| 9 | დოკუმენტები (empty) | SCR-052 | `documents` | დოკუმენტების მართვა |

---

## Tab Bar MAP (Archi → სამეზობლოს)

| Archi | SCR | Route | ფოტო |
|-------|-----|-------|------|
| მთავარი | SCR-010 | `/home` | — |
| ქონება | SCR-080 | `/property` | IMG property |
| პროექტები | SCR-070 | `/projects` | IMG projects |
| ქარდი | SCR-060 | `/offers` | IMG card grid |
| მენიუ | SCR-055 | `/menu` | IMG menu |

---

## Design Tokens (ფოტოებიდან)

| Token | HEX | გამოყენება |
|-------|-----|------------|
| `primary` | `#2F6FED` | ღილაკები, აიკონები, active tab |
| `primary-dark` | `#1A3D6B` | ჰედერის გრადიენტი |
| `primary-light` | `#5B8DEF` | ჰედერის ტალღები |
| `background` | `#F0F4F8` | ეკრანის ფონი |
| `surface` | `#FFFFFF` | ბარათები |
| `text` | `#1A1A1A` | სათაური |
| `text-muted` | `#6B7280` | ქვესათაური |
| `empty-accent` | `#D81B60` | empty state სათაური |
| `border` | `#E2E8F0` | input, ბარათი |
| `label-blue` | `#2F6FED` | ფორმის ლეიბლები |

**ღილაკი CTA:** სრული სიგანე, გრადიენტი `#3B7DDD → #2F6FED`, თეთრი ტექსტი, `border-radius: 12px`, სიმაღლე ~52px.

**უკან:** ლურჯი წრე + ისარი + ტექსტი „უკან“.

**მენიუს ბარათები:** თეთრი, `border-radius: 16px`, ელემენტებს შორის divider, მარჯვნა chevron.

---

## კომპონენტების MAP

| Archi კომპონენტი | კოდის სახელი | SCR |
|------------------|--------------|-----|
| Gradient header | `ArchHeader` | 055, 070, 080 |
| Back + უკან | `BackNav` | ყველა sub-screen |
| Menu card group | `MenuSection` | 055 |
| Menu row | `MenuRow` | 055 |
| Bottom sheet | `BottomSheet` | services |
| Primary CTA | `PrimaryButton` | 030, 052 |
| Empty state | `EmptyState` | 030, 052 |
| Select field (chevron) | `SelectField` | 031 |
| Phone +995 | `PhoneInput` | 031 |
| Payment summary card | `PaymentCard` | 080 |
| Tab bar 5 | `BottomTabs` | global |

---

## SCR-031 ფორმის ველები (ფოტოდან)

| ველი | ტიპი | Required |
|------|------|----------|
| პრობლემის კატეგორია | select | ✓ |
| პრობლემის სახეობა | select (depends on category) | ✓ |
| საგანი | text | |
| ალტერნატიული ნომერი | phone +995 | |
| ალტერნატიული ელ.ფოსტა | email | |
| დამატებითი აღწერილობა | textarea | |
| ფოტო/ვიდეო | file upload | |

**კონტექსტი ზედა ნაწილში (read-only):** ბინა, მისამართი, მფლობელი — `GET /user/unit`.

---

## მენიუს პუნქტების MAP (SCR-055)

| მენიუ (Archi) | → Route | SCR |
|---------------|---------|-----|
| პირადი ინფორმაცია | `/profile` | SCR-050 |
| ჩემი ასისტენტი | `/assistant` | v2 |
| სერვისები | bottom sheet | modal |
| სიახლეები & შეთავაზებები | `/offers` | SCR-060 |
| გადახდები | `/payments` | SCR-020 |
| დოკუმენტების მართვა | `/documents` | SCR-052 |
| ხარვეზის დაფიქსირება | `/service` | SCR-030 |
| სერვის ცენტრები | `/service-centers` | v2 |
| პარამეტრები | `/settings` | SCR-054 |

---

*განახლება: Archi რეფერენს ფოტოები, 2026-06-01*
