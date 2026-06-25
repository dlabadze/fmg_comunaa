# სამეზობლოს — დეველოპერის სპეციფიკაცია (MAP)

> ვერსია: 1.0.0-mvp · პროტოტიპი: `prototype/index.html` · JSON: `data/screen-mapping.json`

## დოკუმენტები

| ფაილი | აუდიტორია |
|-------|-----------|
| `DESIGN_BRIEF.md` | UX / დიზაინი |
| `docs/DEVELOPER_SPEC.md` | დეველოპერი |
| `data/screen-mapping.json` | ეკრან ↔ API MAP |
| `prototype/index.html` | ვიზუალი + SCR ID |

## რეფერენსის MAP

| Archi / DwellUP | Feature | ეკრანი |
|-----------------|---------|--------|
| ხელშეკრულება, ბინა | F-002, F-003 | SCR-051, SCR-052 |
| გადახდები | F-020, F-021 | SCR-020–022 |
| სიახლეები | F-030 | SCR-010, SCR-011 |
| სერვისი | F-040, F-041 | SCR-030–032 |
| მარკეტინგი | F-050, F-051 | SCR-040 |
| Push | F-031 | SCR-053 |
| Auth | F-001 | SCR-003–005 |

## მასტერ MAP

| Feature | Screen ID | Route | API |
|---------|-------------|-------|-----|
| F-001 Auth | SCR-003 | `/auth/login` | POST /auth/login |
| F-010 Dashboard | SCR-010 | `/home` | GET /dashboard |
| F-020 გადახდები | SCR-020 | `/payments` | GET /payments |
| F-021 გადახდა | SCR-021 | `/payments/:id` | POST /payments/:id/pay |
| F-030 სიახლე | SCR-011 | `/news/:id` | GET /news/:id |
| F-040 სერვისი | SCR-031 | `/service/new` | POST /service-requests |
| F-041 სტატუსი | SCR-032 | `/service/:id` | GET /service-requests/:id |
| F-050 მარკეტინგი | SCR-040 | `/marketing` | GET /events |
| F-060 ჩემი სივრცე | SCR-050 | `/profile` | GET /user/me |

## Tab Bar (Archi რეფერენსი)

| Tab | Screen | Route |
|-----|--------|-------|
| home | SCR-010 | /home |
| marketing | SCR-040 | /marketing |
| service | SCR-030 | /service |
| profile | SCR-050 | /profile |

ვიზუალი: `docs/DESIGN_IDENTITY.md`

## ეკრანების სრული სია

| ID | Key | სახელი | P |
|----|-----|--------|---|
| SCR-001 | splash | Splash | P0 |
| SCR-002 | onboarding | Onboarding | P0 |
| SCR-003 | auth | შესვლა | P0 |
| SCR-004 | register | რეგისტრაცია | P0 |
| SCR-005 | otp | OTP | P0 |
| SCR-006 | select-unit | ბინის არჩევა | P1 |
| SCR-010 | home | მთავარი | P0 |
| SCR-011 | news-detail | სიახლე | P1 |
| SCR-020 | payments | გადახდები | P0 |
| SCR-021 | payment-detail | დეტალი | P0 |
| SCR-022 | payment-success | წარმატება | P0 |
| SCR-030 | service | სერვისი | P0 |
| SCR-031 | service-new | ახალი | P0 |
| SCR-032 | service-detail | სტატუსი | P1 |
| SCR-040 | marketing | მარკეტინგი | P1 |
| SCR-050 | profile | მთავარი | P0 |
| SCR-051 | apartment | ჩემი ბინა | P1 |
| SCR-052 | documents | დოკუმენტები | P1 |
| SCR-053 | notifications | შეტყობინებები | P1 |

## API (MVP)

Base: `https://api.samezoblo.ge/v1` · Auth: `Bearer <token>`

```
POST /auth/login          POST /auth/register
POST /auth/verify-otp     GET  /dashboard
GET  /payments            GET  /payments/:id
POST /payments/:id/pay    GET  /service-requests
POST /service-requests    GET  /news
GET  /events              GET  /notifications
GET  /user/me             GET  /documents
```

## მოდელები (TypeScript)

```typescript
interface User { id: string; phone: string; fullName: string; unitId: string; }
interface Unit { buildingName: string; unitNumber: string; complexName: string; }
interface Payment { id: string; title: string; amount: number; dueDate: string; status: 'pending'|'paid'|'overdue'; }
interface ServiceRequest { id: string; category: string; description: string; status: 'new'|'in_progress'|'done'; }
interface NewsItem { id: string; type: string; title: string; excerpt: string; publishedAt: string; }
```

## Expo Router

```
app/(auth)/login.tsx      → SCR-003
app/(tabs)/home.tsx       → SCR-010
app/(tabs)/payments.tsx   → SCR-020
app/payments/[id].tsx     → SCR-021
app/service/new.tsx       → SCR-031
```

## QA

| ID | კრიტერიუმი |
|----|-------------|
| SCR-003 | login → SCR-010 |
| SCR-021 | pay → SCR-022 |
| SCR-031 | ცარიელი აღწერა → error |

*SCR ID = პროტოტიპის `data-screen-id`*
