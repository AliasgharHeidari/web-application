// ============================================================
// DATA - فایل اصلی که همه داده‌ها رو ترکیب می‌کند
// ============================================================

// ابتدا همه فایل‌ها رو به ترتیب لود می‌کنیم
// (این فایل باید بعد از همه فایل‌های دیگه لود بشه)

// فرض می‌کنیم که همه متغیرها در scope سراسری موجود هستند
// (categories, mysteriesArticles, mapArticles, cheatsArticles, charactersArticles)

// ترکیب همه مقالات در یک آرایه
const articles = [
  ...mysteriesArticles,
  ...mapArticles,
  ...cheatsArticles,
  ...charactersArticles
];

// متغیرهای سراسری برای استفاده در app.js
window.categories = categories;
window.articles = articles;