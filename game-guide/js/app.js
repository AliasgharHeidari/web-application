// ============================================================
// CONFIGURATION
// ============================================================

// تنظیم زبان پایه (فارسی)
document.documentElement.setAttribute("lang", "fa");
document.documentElement.setAttribute("dir", "rtl");

// ============================================================
// DOM REFS
// ============================================================

const pages = {
  home: document.getElementById("homePage"),
  category: document.getElementById("categoryPage"),
  guides: document.getElementById("allPage"),
  detail: document.getElementById("detailPage"),
  about: document.getElementById("aboutPage"),
  settings: document.getElementById("settingsPage"),
};

const categoriesContainer = document.getElementById("categories");
const featuredContainer = document.getElementById("featured");
const categoryItems = document.getElementById("categoryItems");
const categoryTitle = document.getElementById("categoryTitle");
const categoryEyebrow = document.getElementById("categoryEyebrow");
const detailContent = document.getElementById("detailContent");
const allArticles = document.getElementById("allArticles");
const searchInput = document.getElementById("searchInput");
const clearSearch = document.getElementById("clearSearch");
const searchResults = document.getElementById("searchResults");
const resultsGrid = document.getElementById("resultsGrid");
const resultCount = document.getElementById("resultCount");
const normalHome = document.getElementById("normalHome");
const sideMenu = document.getElementById("sideMenu");
const menuOverlay = document.getElementById("menuOverlay");
const menuButton = document.getElementById("menuButton");
const closeMenu = document.getElementById("closeMenu");

// ============================================================
// UTILITY: Detect language direction
// ============================================================

function detectDir(text) {
  if (!text) return "auto";
  // الگوی تشخیص زبان فارسی/عربی
  const rtlPattern = /[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]/;
  return rtlPattern.test(text) ? "rtl" : "ltr";
}

function setDir(element, text) {
  if (element && text !== undefined) {
    element.setAttribute("dir", detectDir(text));
  }
  return element;
}

// ============================================================
// PAGE NAVIGATION
// ============================================================

function showPage(name) {
  Object.values(pages).forEach((page) => {
    page.classList.remove("active");
  });

  const page = pages[name];
  if (!page) return;

  page.classList.add("active");
  updateNavigation(name);

  window.scrollTo({
    top: 0,
    behavior: "smooth",
  });
}

// ============================================================
// BOTTOM NAVIGATION
// ============================================================

function updateNavigation(name) {
  document.querySelectorAll(".nav-item").forEach((item) => {
    item.classList.remove("active");
  });

  let navName = name;
  if (name === "category") {
    navName = "categories";
  }

  const nav = document.querySelector(`.nav-item[data-page="${navName}"]`);
  if (nav) {
    nav.classList.add("active");
  }
}

// ============================================================
// SIDE MENU
// ============================================================

function openMenu() {
  sideMenu.classList.add("open");
  menuOverlay.classList.add("open");
  document.body.style.overflow = "hidden";
}

function closeSideMenu() {
  sideMenu.classList.remove("open");
  menuOverlay.classList.remove("open");
  document.body.style.overflow = "";
}

menuButton.addEventListener("click", openMenu);
closeMenu.addEventListener("click", closeSideMenu);
menuOverlay.addEventListener("click", closeSideMenu);

// ============================================================
// MENU ITEMS
// ============================================================

document.querySelectorAll(".menu-link").forEach((item) => {
  item.addEventListener("click", () => {
    const target = item.dataset.menu;

    document.querySelectorAll(".menu-link").forEach((link) => {
      link.classList.remove("active");
    });

    item.classList.add("active");
    closeSideMenu();

    if (target === "categories") {
      showPage("home");
      setTimeout(() => {
        document.getElementById("categories").scrollIntoView({
          behavior: "smooth",
          block: "start",
        });
      }, 80);
      return;
    }

    showPage(target);
  });
});

// ============================================================
// CATEGORIES
// ============================================================

function renderCategories() {
  categoriesContainer.innerHTML = "";

  categories.forEach((category) => {
    const element = document.createElement("button");
    element.className = "category";

    // تشخیص جهت برای عنوان و توضیحات
    const titleDir = detectDir(category.title);
    const descDir = detectDir(category.description);

    element.innerHTML = `
      <div class="category-icon">${category.icon}</div>
      <h3 dir="${titleDir}">${category.title}</h3>
      <p dir="${descDir}">${category.description}</p>
    `;

    element.addEventListener("click", () => openCategory(category.id));
    categoriesContainer.appendChild(element);
  });
}

// ============================================================
// CARD
// ============================================================

function createCard(article) {
  const element = document.createElement("article");
  element.className = "card";

  // استفاده از اولین تصویر برای کارت
  const firstImage = article.images && article.images.length > 0 
    ? article.images[0] 
    : "images/placeholder.jpg";

  const titleDir = detectDir(article.title);
  const descDir = detectDir(article.description);
  const catDir = detectDir(article.category);

  element.innerHTML = `
    <img class="card-image" src="${firstImage}" alt="${article.title}" loading="lazy">
    <div class="card-body">
      <div class="card-category" dir="${catDir}">${article.category}</div>
      <h3 dir="${titleDir}">${article.title}</h3>
      <p dir="${descDir}">${article.description}</p>
    </div>
  `;

  element.addEventListener("click", () => openArticle(article.id));
  return element;
}

// ============================================================
// FEATURED
// ============================================================

function renderFeatured() {
  featuredContainer.innerHTML = "";
  articles.slice(0, 3).forEach((article) => {
    featuredContainer.appendChild(createCard(article));
  });
}

// ============================================================
// ALL ARTICLES
// ============================================================

function renderAllArticles() {
  allArticles.innerHTML = "";

  if (!articles.length) {
    allArticles.innerHTML = `
      <div class="empty-state">
        <strong>No guides available</strong>
        Add guides to data.js.
      </div>
    `;
    return;
  }

  articles.forEach((article) => {
    allArticles.appendChild(createCard(article));
  });
}

// ============================================================
// CATEGORY PAGE
// ============================================================

function openCategory(categoryId) {
  const category = categories.find((item) => item.id === categoryId);
  if (!category) return;

  // تنظیم جهت برای عنوان و توضیحات دسته‌بندی
  setDir(categoryTitle, category.title);
  setDir(categoryEyebrow, category.description);
  categoryTitle.textContent = category.title;
  categoryEyebrow.textContent = category.description;

  const items = articles.filter((article) => article.category === categoryId);
  categoryItems.innerHTML = "";

  if (!items.length) {
    categoryItems.innerHTML = `
      <div class="empty-state">
        <strong>No guides yet</strong>
        More content will be added here.
      </div>
    `;
  } else {
    items.forEach((article) => {
      categoryItems.appendChild(createCard(article));
    });
  }

  showPage("category");
}

// ============================================================
// ARTICLE DETAIL
// ============================================================

function openArticle(id) {
  const article = articles.find((item) => item.id === id);
  if (!article) return;

  const titleDir = detectDir(article.title);
  const descDir = detectDir(article.description);
  const catDir = detectDir(article.category);

  // ============================================================
  // ساخت گالری تصاویر
  // ============================================================
  
  let galleryHTML = "";
  
  if (article.images && article.images.length > 0) {
    galleryHTML = `
      <div class="detail-gallery">
        <div class="gallery-main">
          <img 
            id="galleryMainImage"
            class="detail-image" 
            src="${article.images[0]}" 
            alt="${article.title}"
          >
        </div>
        <div class="gallery-thumbnails">
          ${article.images.map((img, index) => `
            <button 
              class="gallery-thumb ${index === 0 ? 'active' : ''}"
              data-index="${index}"
              onclick="changeGalleryImage(${article.id}, ${index})"
            >
              <img src="${img}" alt="${article.title} - ${index + 1}">
            </button>
          `).join('')}
        </div>
      </div>
    `;
  } else {
    // fallback برای مقالات بدون تصویر
    galleryHTML = `
      <img class="detail-image" src="images/placeholder.jpg" alt="${article.title}">
    `;
  }

  let sectionsHTML = "";
  article.sections.forEach((section) => {
    const sectionTitleDir = detectDir(section.title);
    const sectionTextDir = detectDir(section.text);
    sectionsHTML += `
      <section class="detail-section">
        <h2 dir="${sectionTitleDir}">${section.title}</h2>
        <p dir="${sectionTextDir}">${section.text}</p>
      </section>
    `;
  });

  detailContent.innerHTML = `
    <span class="eyebrow detail-category" dir="${catDir}">${article.category}</span>
    <h1 class="detail-title-fa" dir="${titleDir}">${article.title}</h1>
    
    ${galleryHTML}
    
    <p class="detail-description" dir="${descDir}">${article.description}</p>
    ${sectionsHTML}
  `;

  showPage("detail");
}

// ============================================================
// تابع تغییر تصویر گالری (Global برای استفاده در onclick)
// ============================================================

function changeGalleryImage(articleId, index) {
  const article = articles.find((item) => item.id === articleId);
  if (!article || !article.images) return;

  const mainImage = document.getElementById("galleryMainImage");
  if (mainImage) {
    mainImage.src = article.images[index];
  }

  // به‌روزرسانی کلاس active برای thumbnail‌ها
  document.querySelectorAll(".gallery-thumb").forEach((thumb, i) => {
    thumb.classList.toggle("active", i === index);
  });
}

// اضافه کردن تابع به window برای استفاده در onclick
window.changeGalleryImage = changeGalleryImage;

// ============================================================
// SEARCH
// ============================================================

function search(query) {
  const value = query.trim().toLowerCase();

  if (!value) {
    searchResults.classList.add("hidden");
    normalHome.classList.remove("hidden");
    clearSearch.classList.remove("visible");
    return;
  }

  clearSearch.classList.add("visible");
  normalHome.classList.add("hidden");
  searchResults.classList.remove("hidden");

  const results = articles.filter((article) => {
    return (
      article.title.toLowerCase().includes(value) ||
      article.description.toLowerCase().includes(value) ||
      article.category.toLowerCase().includes(value) ||
      article.sections.some(
        (section) =>
          section.title.toLowerCase().includes(value) ||
          section.text.toLowerCase().includes(value)
      )
    );
  });

  resultCount.textContent = results.length;
  resultsGrid.innerHTML = "";

  if (!results.length) {
    resultsGrid.innerHTML = `
      <div class="empty-state">
        <strong>Nothing found</strong>
        Try another search term.
      </div>
    `;
    return;
  }

  results.forEach((article) => {
    resultsGrid.appendChild(createCard(article));
  });
}

searchInput.addEventListener("input", (event) => search(event.target.value));

// ============================================================
// CLEAR SEARCH
// ============================================================

clearSearch.addEventListener("click", () => {
  searchInput.value = "";
  search("");
  searchInput.focus();
});

// ============================================================
// HEADER SEARCH
// ============================================================

document.getElementById("headerSearchButton").addEventListener("click", () => {
  showPage("home");
  searchInput.focus();
});

// ============================================================
// BACK BUTTONS
// ============================================================

document.getElementById("backButton").addEventListener("click", () => {
  showPage("home");
});

document.getElementById("categoryBackButton").addEventListener("click", () => {
  showPage("home");
});

// ============================================================
// VIEW ALL
// ============================================================

document.getElementById("viewAllButton").addEventListener("click", () => {
  showPage("guides");
});

document.getElementById("categoriesViewAll").addEventListener("click", () => {
  showPage("home");
  setTimeout(() => {
    document.getElementById("categories").scrollIntoView({
      behavior: "smooth",
    });
  }, 80);
});

// ============================================================
// BOTTOM NAV
// ============================================================

document.querySelectorAll(".nav-item").forEach((item) => {
  item.addEventListener("click", () => {
    const target = item.dataset.page;

    if (target === "categories") {
      showPage("home");
      setTimeout(() => {
        document.getElementById("categories").scrollIntoView({
          behavior: "smooth",
          block: "start",
        });
      }, 80);
      return;
    }

    showPage(target);
  });
});

// ============================================================
// DARK MODE
// ============================================================

document.getElementById("darkModeToggle").addEventListener("change", (event) => {
  document.body.classList.toggle("light-mode", !event.target.checked);
});

// ============================================================
// ANIMATIONS
// ============================================================

document.getElementById("animationToggle").addEventListener("change", (event) => {
  document.body.classList.toggle("no-animations", !event.target.checked);
});

// ============================================================
// INTRO VIDEO
// ============================================================

const introScreen = document.getElementById("introScreen");
const introVideo = document.getElementById("introVideo");
const skipIntro = document.getElementById("skipIntro");

let introFinished = false;

function finishIntro() {
  if (introFinished) return;
  introFinished = true;

  introScreen.classList.add("finished");
  document.body.style.overflow = "";

  if (introVideo) {
    introVideo.pause();
  }

  setTimeout(() => {
    introScreen.remove();
  }, 750);
}

if (introVideo) {
  introVideo.addEventListener("ended", finishIntro);
}

if (skipIntro) {
  skipIntro.addEventListener("click", finishIntro);
}

if (introVideo) {
  const playPromise = introVideo.play();
  if (playPromise !== undefined) {
    playPromise.catch(() => {
      setTimeout(finishIntro, 2500);
    });
  }
}

if (introVideo) {
  introVideo.addEventListener("error", () => {
    setTimeout(finishIntro, 800);
  });
}

// ============================================================
// INITIALIZE
// ============================================================

renderCategories();
renderFeatured();
renderAllArticles();

// ============================================================
// SAFETY FALLBACK
// ============================================================

setTimeout(finishIntro, 1000);