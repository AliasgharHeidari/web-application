// ============================================================
// CONFIGURATION
// ============================================================

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
// UTILITY
// ============================================================

function detectDir(text) {
  if (!text) return "auto";
  const rtlPattern =
    /[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]/;
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
    const titleDir = detectDir(category.title);
    const descDir = detectDir(category.description);
    element.innerHTML = `
      <div class="category-icon">${category.icon || ''}</div>
      <h3 dir="${titleDir}">${category.title}</h3>
      <p dir="${descDir}">${category.description || ''}</p>
    `;
    element.addEventListener("click", () => openCategory(category.id));
    categoriesContainer.appendChild(element);
  });
}

// ============================================================
// CARD - با پشتیبانی از containsImage
// ============================================================

function createCard(article) {
  const element = document.createElement("article");
  element.className = "card";

  // بررسی containsImage
  const hasImage = article.containsImage !== false && 
                   article.images && 
                   article.images.length > 0;

  const firstImage = hasImage ? article.images[0] : null;

  const titleDir = detectDir(article.title);
  const descDir = detectDir(article.description);
  const catDir = detectDir(article.category);
  
  const mapBadge = article.isMap ? '<span class="map-badge">🗺️</span>' : "";
  
  // نمایش نقشه در کارت
  const isMap = article.isMap ? 'data-map="true"' : '';

  // ساخت HTML کارت - بدون عکس اگر containsImage: false باشد
  let imageHTML = '';
  if (hasImage && firstImage) {
    imageHTML = `<img class="card-image" src="${firstImage}" alt="${article.title}" loading="lazy">`;
  } else {
    // اگر عکس نداره، یه کلاس خاص برای استایل‌دهی
    element.classList.add('no-image');
  }

  element.innerHTML = `
    ${imageHTML}
    <div class="card-body">
      <div class="card-category" dir="${catDir}">${article.category} ${mapBadge}</div>
      <h3 dir="${titleDir}">${article.title}</h3>
      <p dir="${descDir}">${article.description}</p>
    </div>
  `;

  element.addEventListener("click", () => openArticle(article.id));
  return element;
}

function renderFeatured() {
  featuredContainer.innerHTML = "";
  articles.slice(0, 3).forEach((article) => {
    featuredContainer.appendChild(createCard(article));
  });
}

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

function openCategory(categoryId) {
  const category = categories.find((item) => item.id === categoryId);
  if (!category) return;

  setDir(categoryTitle, category.title);
  setDir(categoryEyebrow, category.description);
  categoryTitle.textContent = category.title;
  categoryEyebrow.textContent = category.description || '';

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
// IMAGE VIEWER - نسخه کامل
// ============================================================

function openImageViewer(images, initialIndex = 0) {
  if (document.getElementById("imageViewer")) {
    return;
  }

  let currentIndex = initialIndex;
  let scale = 1;
  let translateX = 0;
  let translateY = 0;
  let isDragging = false;
  let startX = 0;
  let startY = 0;
  let lastTranslateX = 0;
  let lastTranslateY = 0;

  const overlay = document.createElement("div");
  overlay.className = "image-viewer-overlay";
  overlay.id = "imageViewer";
  overlay.style.cssText = `
    position: fixed;
    inset: 0;
    z-index: 9999;
    background: rgba(0,0,0,0.92);
    backdrop-filter: blur(20px);
    display: flex;
    align-items: center;
    justify-content: center;
    animation: viewerFadeIn 0.25s ease;
  `;

  overlay.innerHTML = `
    <div style="
      width: 100%;
      height: 100%;
      max-width: 1200px;
      max-height: 900px;
      display: flex;
      flex-direction: column;
      padding: 20px;
      position: relative;
    ">
      <button id="viewerClose" style="
        position: absolute;
        top: 20px;
        right: 20px;
        z-index: 10;
        width: 44px;
        height: 44px;
        border-radius: 50%;
        background: rgba(255,255,255,0.1);
        border: 1px solid rgba(255,255,255,0.2);
        color: #fff;
        font-size: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: background 0.2s;
      ">✕</button>
      
      <div style="
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow: hidden;
      ">
        <div id="viewerWrapper" style="
          flex: 1;
          width: 100%;
          display: flex;
          align-items: center;
          justify-content: center;
          overflow: hidden;
          position: relative;
          cursor: grab;
          user-select: none;
          touch-action: none;
        ">
          <img 
            id="viewerImage" 
            src="${images[initialIndex]}" 
            alt="Image"
            draggable="false"
            style="
              max-width: 100%;
              max-height: 100%;
              object-fit: contain;
              transform: translate(0px, 0px) scale(1);
              transform-origin: center center;
              pointer-events: none;
              will-change: transform;
            "
          >
        </div>
        
        <div style="
          position: absolute;
          bottom: 90px;
          left: 50%;
          transform: translateX(-50%);
          display: flex;
          gap: 8px;
          background: rgba(0,0,0,0.6);
          padding: 8px 12px;
          border-radius: 12px;
          backdrop-filter: blur(10px);
          border: 1px solid rgba(255,255,255,0.1);
        ">
          <button class="viewer-btn" id="viewerZoomIn" style="
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
          ">➕</button>
          <button class="viewer-btn" id="viewerZoomOut" style="
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
          ">➖</button>
          <button class="viewer-btn" id="viewerReset" style="
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
          ">⟲</button>
        </div>
        
        <div class="image-viewer-thumbnails" style="
          display: flex;
          gap: 8px;
          margin-top: 12px;
          overflow-x: auto;
          padding: 4px 0;
          max-width: 80%;
          scrollbar-width: thin;
        ">
          ${images
            .map(
              (img, index) => `
            <button 
              class="viewer-thumb ${index === initialIndex ? "active" : ""}"
              data-index="${index}"
              style="
                flex-shrink: 0;
                width: 70px;
                height: 50px;
                border-radius: 6px;
                overflow: hidden;
                border: ${index === initialIndex ? "2px solid #fff" : "2px solid transparent"};
                background: transparent;
                padding: 0;
                cursor: pointer;
              "
            >
              <img src="${img}" alt="Thumbnail ${index + 1}" style="width:100%;height:100%;object-fit:cover;display:block;">
            </button>
          `,
            )
            .join("")}
        </div>
        
        <div style="
          position: absolute;
          top: 20px;
          left: 50%;
          transform: translateX(-50%);
          color: rgba(255,255,255,0.5);
          font-size: 14px;
          font-weight: 500;
          letter-spacing: 1px;
        ">
          ${initialIndex + 1} / ${images.length}
        </div>
      </div>
    </div>
  `;

  document.body.appendChild(overlay);
  document.body.style.overflow = "hidden";

  const viewerImage = document.getElementById("viewerImage");
  const viewerWrapper = document.getElementById("viewerWrapper");
  const viewerClose = document.getElementById("viewerClose");
  const zoomInBtn = document.getElementById("viewerZoomIn");
  const zoomOutBtn = document.getElementById("viewerZoomOut");
  const resetBtn = document.getElementById("viewerReset");
  const thumbnails = overlay.querySelectorAll(".viewer-thumb");
  const counter = overlay.querySelector(".image-viewer-counter");

  function updateTransform() {
    viewerImage.style.transform = `translate(${translateX}px, ${translateY}px) scale(${scale})`;
  }

  function loadImage(index) {
    currentIndex = index;
    viewerImage.src = images[index];
    scale = 1;
    translateX = 0;
    translateY = 0;
    updateTransform();

    thumbnails.forEach((thumb, i) => {
      thumb.style.border =
        i === index ? "2px solid #fff" : "2px solid transparent";
    });

    counter.textContent = `${index + 1} / ${images.length}`;
  }

  function zoomIn() {
    scale = Math.min(scale + 0.25, 5);
    updateTransform();
  }

  function zoomOut() {
    scale = Math.max(scale - 0.25, 0.5);
    updateTransform();
  }

  function resetView() {
    scale = 1;
    translateX = 0;
    translateY = 0;
    updateTransform();
  }

  function closeViewer() {
    if (overlay.parentNode) {
      overlay.remove();
    }
    document.body.style.overflow = "";
    document.removeEventListener("keydown", handleKeyDown);
  }

  function handleKeyDown(e) {
    if (e.key === "Escape") {
      closeViewer();
      e.preventDefault();
    } else if (e.key === "ArrowRight" || e.key === "ArrowDown") {
      const nextIndex = (currentIndex + 1) % images.length;
      loadImage(nextIndex);
      e.preventDefault();
    } else if (e.key === "ArrowLeft" || e.key === "ArrowUp") {
      const prevIndex = (currentIndex - 1 + images.length) % images.length;
      loadImage(prevIndex);
      e.preventDefault();
    }
  }

  document.addEventListener("keydown", handleKeyDown);

  viewerClose.addEventListener("click", closeViewer);

  overlay.addEventListener("click", (e) => {
    if (e.target === overlay) {
      closeViewer();
    }
  });

  zoomInBtn.addEventListener("click", zoomIn);
  zoomOutBtn.addEventListener("click", zoomOut);
  resetBtn.addEventListener("click", resetView);

  viewerWrapper.addEventListener(
    "wheel",
    (e) => {
      e.preventDefault();
      if (e.deltaY < 0) {
        zoomIn();
      } else {
        zoomOut();
      }
    },
    { passive: false },
  );

  // Drag with mouse
  viewerWrapper.addEventListener("mousedown", (e) => {
    if (e.button !== 0) return;
    isDragging = true;
    startX = e.clientX;
    startY = e.clientY;
    lastTranslateX = translateX;
    lastTranslateY = translateY;
    viewerWrapper.style.cursor = "grabbing";
    e.preventDefault();
  });

  document.addEventListener("mousemove", (e) => {
    if (!isDragging) return;
    const deltaX = e.clientX - startX;
    const deltaY = e.clientY - startY;
    translateX = lastTranslateX + deltaX;
    translateY = lastTranslateY + deltaY;
    updateTransform();
  });

  document.addEventListener("mouseup", () => {
    if (isDragging) {
      isDragging = false;
      viewerWrapper.style.cursor = "grab";
    }
  });

  // Touch events
  let touchStartX = 0;
  let touchStartY = 0;
  let touchLastX = 0;
  let touchLastY = 0;
  let isTouching = false;
  let touchId = null;
  let lastPinchDist = 0;
  let pinchScale = 1;

  viewerWrapper.addEventListener(
    "touchstart",
    (e) => {
      if (e.touches.length === 1) {
        const touch = e.touches[0];
        isTouching = true;
        touchId = touch.identifier;
        touchStartX = touch.clientX;
        touchStartY = touch.clientY;
        touchLastX = translateX;
        touchLastY = translateY;
      } else if (e.touches.length === 2) {
        const t1 = e.touches[0];
        const t2 = e.touches[1];
        lastPinchDist = Math.hypot(
          t1.clientX - t2.clientX,
          t1.clientY - t2.clientY,
        );
        pinchScale = scale;
        isTouching = false;
      }
    },
    { passive: true },
  );

  viewerWrapper.addEventListener(
    "touchmove",
    (e) => {
      e.preventDefault();
      if (e.touches.length === 1 && isTouching) {
        const touch = e.touches[0];
        if (touch.identifier === touchId) {
          const deltaX = touch.clientX - touchStartX;
          const deltaY = touch.clientY - touchStartY;
          translateX = touchLastX + deltaX;
          translateY = touchLastY + deltaY;
          updateTransform();
        }
      }
      if (e.touches.length === 2) {
        const t1 = e.touches[0];
        const t2 = e.touches[1];
        const dist = Math.hypot(
          t1.clientX - t2.clientX,
          t1.clientY - t2.clientY,
        );
        if (lastPinchDist > 0) {
          const ratio = dist / lastPinchDist;
          let newScale = pinchScale * ratio;
          newScale = Math.min(Math.max(newScale, 0.5), 5);
          scale = newScale;
          updateTransform();
        }
      }
    },
    { passive: false },
  );

  viewerWrapper.addEventListener(
    "touchend",
    () => {
      isTouching = false;
      touchId = null;
      lastPinchDist = 0;
    },
    { passive: true },
  );

  thumbnails.forEach((thumb) => {
    thumb.addEventListener("click", () => {
      const index = parseInt(thumb.dataset.index);
      loadImage(index);
    });
  });

  viewerImage.addEventListener("dblclick", resetView);
  viewerWrapper.style.cursor = "grab";
}

// ============================================================
// SETUP GALLERY CLICK - برای باز شدن Image Viewer با کلیک روی عکس
// ============================================================

function setupGalleryClick(articleId) {
  const mainImage = document.getElementById('galleryMainImage');
  if (mainImage) {
    const article = articles.find(a => a.id === articleId);
    if (article && article.images && article.images.length > 0) {
      mainImage.style.cursor = 'pointer';
      // حذف event listener قبلی با clone
      const newMainImage = mainImage.cloneNode(true);
      mainImage.parentNode.replaceChild(newMainImage, mainImage);
      newMainImage.addEventListener('click', () => {
        openImageViewer(article.images, 0);
      });
      // ذخیره reference برای تابع changeGalleryImage
      document.getElementById('galleryMainImage')?.setAttribute('data-article-id', articleId);
    }
  }
}

// ============================================================
// OPEN ARTICLE - نسخه نهایی با پشتیبانی از containsImage و aspect ratio
// ============================================================

function openArticle(id) {
  const article = articles.find((item) => item.id === id);
  if (!article) return;

  // اگر مقاله نقشه است → مستقیم Image Viewer
  if (article.isMap && article.images && article.images.length > 0) {
    openImageViewer(article.images, 0);
    return;
  }

  const titleDir = detectDir(article.title);
  const descDir = detectDir(article.description);
  const catDir = detectDir(article.category);

  // بررسی containsImage برای نمایش گالری
  const hasImage = article.containsImage !== false && 
                   article.images && 
                   article.images.length > 0;

  let galleryHTML = "";
  if (hasImage) {
    galleryHTML = `
      <div class="detail-gallery">
        <div class="gallery-main">
          <img id="galleryMainImage" class="detail-image" src="${article.images[0]}" alt="${article.title}" loading="lazy">
        </div>
        ${article.images.length > 1 ? `
          <div class="gallery-thumbnails">
            ${article.images
              .map(
                (img, index) => `
              <button class="gallery-thumb ${index === 0 ? "active" : ""}" data-index="${index}" onclick="changeGalleryImage(${article.id}, ${index})">
                <img src="${img}" alt="${article.title} - ${index + 1}" loading="lazy">
              </button>
            `,
              )
              .join("")}
          </div>
        ` : ''}
      </div>
    `;
  }

  let sectionsHTML = "";
  if (article.sections && article.sections.length > 0) {
    article.sections.forEach((section) => {
      const sectionTitleDir = detectDir(section.title);
      const sectionTextDir = detectDir(section.text);
      sectionsHTML += `
        <section class="detail-section">
          <h2 dir="${sectionTitleDir}">${section.title}</h2>
          <p dir="${sectionTextDir}">${section.text.replace(/\n/g, '<br>')}</p>
        </section>
      `;
    });
  }

  detailContent.innerHTML = `
    <span class="eyebrow detail-category" dir="${catDir}">${article.category}</span>
    <h1 class="detail-title-fa" dir="${titleDir}">${article.title}</h1>
    ${galleryHTML}
    <p class="detail-description" dir="${descDir}">${article.description || ''}</p>
    ${sectionsHTML}
  `;

  // راه‌اندازی کلیک روی عکس برای باز شدن Image Viewer
  if (hasImage && article.images.length > 0) {
    setupGalleryClick(article.id);
  }

  showPage("detail");
}

// ============================================================
// CHANGE GALLERY IMAGE - به‌روز شده با پشتیبانی از کلیک
// ============================================================

function changeGalleryImage(articleId, index) {
  const article = articles.find((item) => item.id === articleId);
  if (!article || !article.images) return;

  const mainImage = document.getElementById("galleryMainImage");
  if (mainImage) {
    mainImage.src = article.images[index];
    // آپدیت کردن event listener برای تصویر جدید
    mainImage.onclick = () => openImageViewer(article.images, index);
    mainImage.style.cursor = 'pointer';
  }

  document.querySelectorAll(".gallery-thumb").forEach((thumb, i) => {
    thumb.classList.toggle("active", i === index);
  });
}
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
      (article.sections && article.sections.some(
        (section) =>
          section.title.toLowerCase().includes(value) ||
          section.text.toLowerCase().includes(value),
      ))
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

clearSearch.addEventListener("click", () => {
  searchInput.value = "";
  search("");
  searchInput.focus();
});

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
// DARK MODE & ANIMATIONS
// ============================================================

document
  .getElementById("darkModeToggle")
  .addEventListener("change", (event) => {
    document.body.classList.toggle("light-mode", !event.target.checked);
  });

document
  .getElementById("animationToggle")
  .addEventListener("change", (event) => {
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
  if (introVideo) introVideo.pause();
  setTimeout(() => introScreen.remove(), 750);
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
    playPromise.catch(() => setTimeout(finishIntro, 2500));
  }
}
if (introVideo) {
  introVideo.addEventListener("error", () => setTimeout(finishIntro, 800));
}

// ============================================================
// INITIALIZE
// ============================================================

renderCategories();
renderFeatured();
renderAllArticles();
setTimeout(finishIntro, 10);

console.log('✅ GTA V Guide App initialized successfully!');
console.log(`📊 Loaded ${articles.length} articles in ${categories.length} categories`);