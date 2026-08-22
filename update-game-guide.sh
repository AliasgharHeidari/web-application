#!/usr/bin/env bash

set -e

PROJECT="game-guide"

if [ ! -d "$PROJECT" ]; then
    echo "Error: $PROJECT directory not found."
    echo "Run the previous project creation script first."
    exit 1
fi

mkdir -p "$PROJECT/css" "$PROJECT/js" "$PROJECT/images"


cat > "$PROJECT/index.html" <<'HTML'
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <meta
        name="theme-color"
        content="#0d0e12"
    >

    <title>Game Guide</title>

    <link
        rel="stylesheet"
        href="css/style.css"
    >

</head>


<body>

    <!-- =========================
         APP
    ========================== -->

    <div class="app">


        <!-- =========================
             HEADER
        ========================== -->

        <header class="topbar">

            <button
                class="icon-button"
                id="menuButton"
                aria-label="Menu"
            >
                ☰
            </button>


            <div class="brand">

                <span class="brand-mark">◆</span>

                <span>
                    GAME GUIDE
                </span>

            </div>


            <button
                class="icon-button"
                id="headerSearchButton"
                aria-label="Search"
            >
                ⌕
            </button>

        </header>


        <!-- =========================
             MAIN
        ========================== -->

        <main>


            <!-- =====================
                 HOME
            ====================== -->

            <section
                id="homePage"
                class="page active"
            >

                <div class="home-content">


                    <!-- SEARCH -->

                    <div class="search-box">

                        <span class="search-icon">
                            ⌕
                        </span>

                        <input
                            id="searchInput"
                            type="search"
                            placeholder="Search the guide..."
                            autocomplete="off"
                        >

                        <button
                            id="clearSearch"
                            class="clear-search"
                            aria-label="Clear search"
                        >
                            ×
                        </button>

                    </div>


                    <!-- SEARCH RESULTS -->

                    <div
                        id="searchResults"
                        class="search-results hidden"
                    >

                        <div class="section-title">

                            <span>
                                Search results
                            </span>

                            <span
                                id="resultCount"
                                class="muted"
                            >
                                0
                            </span>

                        </div>

                        <div
                            id="resultsGrid"
                            class="card-grid"
                        ></div>

                    </div>


                    <!-- NORMAL HOME -->

                    <div id="normalHome">


                        <!-- CATEGORIES -->

                        <section class="section">

                            <div class="section-header">

                                <h2>
                                    Categories
                                </h2>

                            </div>


                            <div
                                id="categories"
                                class="category-grid"
                            ></div>

                        </section>


                        <!-- FEATURED -->

                        <section class="section">

                            <div class="section-header">

                                <h2>
                                    Featured
                                </h2>

                                <button
                                    id="viewAllButton"
                                    class="text-button"
                                >
                                    View all
                                </button>

                            </div>


                            <div
                                id="featured"
                                class="card-grid"
                            ></div>

                        </section>


                    </div>

                </div>

            </section>


            <!-- =====================
                 CATEGORY PAGE
            ====================== -->

            <section
                id="categoryPage"
                class="page"
            >

                <div class="page-content">


                    <button
                        id="categoryBackButton"
                        class="back-button"
                    >
                        ← Back
                    </button>


                    <div class="page-heading">

                        <span
                            id="categoryEyebrow"
                            class="eyebrow"
                        >
                            CATEGORY
                        </span>

                        <h1 id="categoryTitle">
                            Category
                        </h1>

                    </div>


                    <div
                        id="categoryItems"
                        class="card-grid"
                    ></div>

                </div>

            </section>


            <!-- =====================
                 DETAIL PAGE
            ====================== -->

            <section
                id="detailPage"
                class="page"
            >

                <div class="detail-page">


                    <button
                        id="backButton"
                        class="back-button"
                    >
                        ← Back
                    </button>


                    <div id="detailContent"></div>


                </div>

            </section>


            <!-- =====================
                 ALL ARTICLES
            ====================== -->

            <section
                id="allPage"
                class="page"
            >

                <div class="page-content">

                    <div class="page-heading">

                        <span class="eyebrow">
                            GUIDE
                        </span>

                        <h1>
                            All Guides
                        </h1>

                    </div>


                    <div
                        id="allArticles"
                        class="card-grid"
                    ></div>

                </div>

            </section>


        </main>


        <!-- =========================
             BOTTOM NAVIGATION
        ========================== -->

        <nav class="bottom-nav">


            <button
                class="nav-item active"
                data-page="home"
            >

                <span class="nav-icon">
                    ⌂
                </span>

                <span>
                    Home
                </span>

            </button>


            <button
                class="nav-item"
                data-page="categories"
            >

                <span class="nav-icon">
                    ▦
                </span>

                <span>
                    Categories
                </span>

            </button>


            <button
                class="nav-item"
                data-page="all"
            >

                <span class="nav-icon">
                    ☰
                </span>

                <span>
                    Guides
                </span>

            </button>


        </nav>


    </div>


    <script src="js/data.js"></script>

    <script src="js/app.js"></script>

</body>

</html>
HTML


cat > "$PROJECT/css/style.css" <<'CSS'
:root {

    --background: #0d0e12;

    --surface: #14151a;

    --surface-hover: #1a1b21;

    --border: #24262d;

    --text: #f2f3f5;

    --muted: #8d919b;

    --accent: #ffffff;

    --danger: #ff6b6b;

    --radius: 14px;

}


* {

    box-sizing: border-box;

}


html {

    scroll-behavior: smooth;

}


body {

    margin: 0;

    min-height: 100vh;

    background: var(--background);

    color: var(--text);

    font-family:
        Inter,
        system-ui,
        -apple-system,
        BlinkMacSystemFont,
        "Segoe UI",
        sans-serif;

    -webkit-font-smoothing: antialiased;

}


button,
input {

    font: inherit;

}


button {

    border: 0;

    cursor: pointer;

}


.app {

    min-height: 100vh;

    padding-bottom: 74px;

}


/* =========================
   TOP BAR
========================= */

.topbar {

    height: 62px;

    display: grid;

    grid-template-columns: 45px 1fr 45px;

    align-items: center;

    position: sticky;

    top: 0;

    z-index: 100;

    padding: 0 12px;

    background:
        rgba(13, 14, 18, .92);

    border-bottom:
        1px solid var(--border);

    backdrop-filter:
        blur(16px);

}


.brand {

    display: flex;

    align-items: center;

    justify-content: center;

    gap: 9px;

    font-size: 12px;

    font-weight: 800;

    letter-spacing: 1.8px;

}


.brand-mark {

    font-size: 11px;

}


.icon-button {

    width: 40px;

    height: 40px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: transparent;

    color: var(--text);

    border-radius: 10px;

    font-size: 19px;

}


.icon-button:active {

    background: var(--surface);

}


/* =========================
   PAGES
========================= */

.page {

    display: none;

}


.page.active {

    display: block;

}


.home-content,
.page-content,
.detail-page {

    width: min(100% - 28px, 1050px);

    margin: 0 auto;

}


.home-content {

    padding-top: 18px;

}


.page-content {

    padding-top: 24px;

    padding-bottom: 40px;

}


.detail-page {

    padding-top: 20px;

    padding-bottom: 60px;

}


/* =========================
   SEARCH
========================= */

.search-box {

    height: 50px;

    display: flex;

    align-items: center;

    gap: 10px;

    padding: 0 14px;

    background: var(--surface);

    border: 1px solid var(--border);

    border-radius: 12px;

    transition:
        border-color .2s,
        box-shadow .2s;

}


.search-box:focus-within {

    border-color: #4b4e58;

    box-shadow:
        0 0 0 3px
        rgba(255,255,255,.035);

}


.search-icon {

    color: var(--muted);

    font-size: 20px;

}


.search-box input {

    flex: 1;

    min-width: 0;

    height: 100%;

    border: 0;

    outline: 0;

    background: transparent;

    color: var(--text);

}


.search-box input::placeholder {

    color: #6f737d;

}


.clear-search {

    display: none;

    width: 28px;

    height: 28px;

    border-radius: 50%;

    background: #24262d;

    color: var(--muted);

}


.clear-search.visible {

    display: block;

}


/* =========================
   SECTIONS
========================= */

.section {

    margin-top: 30px;

}


.section-header {

    display: flex;

    align-items: center;

    justify-content: space-between;

    margin-bottom: 13px;

}


.section-header h2 {

    margin: 0;

    font-size: 18px;

    font-weight: 700;

}


.text-button {

    background: transparent;

    color: var(--muted);

    font-size: 13px;

}


.text-button:hover {

    color: var(--text);

}


.section-title {

    display: flex;

    align-items: center;

    justify-content: space-between;

    margin: 25px 0 13px;

    font-size: 16px;

    font-weight: 700;

}


.muted {

    color: var(--muted);

    font-size: 13px;

}


/* =========================
   CATEGORIES
========================= */

.category-grid {

    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 10px;

}


.category {

    min-height: 105px;

    display: flex;

    flex-direction: column;

    justify-content: center;

    padding: 17px;

    background: var(--surface);

    border: 1px solid var(--border);

    border-radius: var(--radius);

    transition:
        background .18s,
        transform .18s,
        border-color .18s;

}


.category:active {

    transform: scale(.98);

}


.category:hover {

    background: var(--surface-hover);

    border-color: #363943;

}


.category-icon {

    width: 32px;

    height: 32px;

    display: flex;

    align-items: center;

    justify-content: center;

    margin-bottom: 10px;

    border-radius: 9px;

    background: #1d1f25;

    color: var(--text);

    font-size: 16px;

}


.category h3 {

    margin: 0 0 4px;

    font-size: 14px;

}


.category p {

    margin: 0;

    color: var(--muted);

    font-size: 11px;

    line-height: 1.4;

}


/* =========================
   CARDS
========================= */

.card-grid {

    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 12px;

}


.card {

    overflow: hidden;

    background: var(--surface);

    border: 1px solid var(--border);

    border-radius: var(--radius);

    transition:
        transform .18s,
        background .18s,
        border-color .18s;

}


.card:hover {

    background: var(--surface-hover);

    border-color: #363943;

}


.card:active {

    transform: scale(.985);

}


.card-image {

    width: 100%;

    display: block;

    aspect-ratio: 16 / 9;

    object-fit: cover;

    background: #181a20;

}


.card-body {

    padding: 14px;

}


.card-category {

    color: var(--muted);

    font-size: 9px;

    font-weight: 800;

    letter-spacing: 1.5px;

    text-transform: uppercase;

}


.card h3 {

    margin: 7px 0 5px;

    font-size: 15px;

}


.card p {

    margin: 0;

    color: var(--muted);

    font-size: 12px;

    line-height: 1.55;

}


/* =========================
   PAGE HEADINGS
========================= */

.page-heading {

    margin-bottom: 22px;

}


.eyebrow {

    color: var(--muted);

    font-size: 9px;

    font-weight: 800;

    letter-spacing: 2px;

    text-transform: uppercase;

}


.page-heading h1 {

    margin: 7px 0 0;

    font-size: 30px;

    letter-spacing: -1px;

}


/* =========================
   BACK BUTTON
========================= */

.back-button {

    display: inline-flex;

    align-items: center;

    gap: 6px;

    margin-bottom: 24px;

    padding: 9px 13px;

    background: var(--surface);

    color: var(--text);

    border: 1px solid var(--border);

    border-radius: 9px;

    font-size: 12px;

}


.back-button:active {

    transform: scale(.97);

}


/* =========================
   DETAIL
========================= */

.detail-category {

    display: block;

    margin-bottom: 7px;

}


.detail-page h1 {

    margin: 0 0 18px;

    font-size: clamp(30px, 6vw, 48px);

    line-height: 1.05;

    letter-spacing: -1.5px;

}


.detail-image {

    width: 100%;

    display: block;

    aspect-ratio: 16 / 8;

    object-fit: cover;

    border-radius: var(--radius);

    border: 1px solid var(--border);

}


.detail-description {

    margin: 20px 0 0;

    color: #b4b7c0;

    font-size: 15px;

    line-height: 1.8;

}


.detail-section {

    margin-top: 32px;

    padding-top: 24px;

    border-top: 1px solid var(--border);

}


.detail-section h2 {

    margin: 0 0 10px;

    font-size: 19px;

}


.detail-section p {

    margin: 0;

    color: #a9acb5;

    font-size: 14px;

    line-height: 1.85;

}


/* =========================
   BOTTOM NAV
========================= */

.bottom-nav {

    position: fixed;

    left: 0;

    right: 0;

    bottom: 0;

    z-index: 200;

    height: 68px;

    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    padding:
        7px
        max(7px, env(safe-area-inset-right))
        calc(7px + env(safe-area-inset-bottom))
        max(7px, env(safe-area-inset-left));

    background:
        rgba(17, 18, 23, .96);

    border-top:
        1px solid var(--border);

    backdrop-filter:
        blur(18px);

}


.nav-item {

    display: flex;

    flex-direction: column;

    align-items: center;

    justify-content: center;

    gap: 3px;

    background: transparent;

    color: #777b85;

    font-size: 10px;

    transition: color .15s;

}


.nav-item.active {

    color: var(--text);

}


.nav-icon {

    font-size: 18px;

    line-height: 20px;

}


/* =========================
   SEARCH RESULTS
========================= */

.hidden {

    display: none !important;

}


.search-results {

    padding-bottom: 40px;

}


/* =========================
   EMPTY STATE
========================= */

.empty-state {

    padding: 50px 20px;

    text-align: center;

    color: var(--muted);

}


.empty-state strong {

    display: block;

    margin-bottom: 8px;

    color: var(--text);

}


/* =========================
   MOBILE
========================= */

@media (max-width: 700px) {

    .category-grid {

        grid-template-columns:
            repeat(2, 1fr);

    }


    .card-grid {

        grid-template-columns:
            repeat(2, 1fr);

    }

}


@media (max-width: 480px) {

    .category-grid {

        gap: 8px;

    }


    .category {

        min-height: 100px;

        padding: 13px;

    }


    .card-grid {

        grid-template-columns: 1fr;

        gap: 10px;

    }


    .card {

        display: grid;

        grid-template-columns: 125px 1fr;

    }


    .card-image {

        height: 100%;

        aspect-ratio: auto;

        min-height: 110px;

    }


    .card-body {

        display: flex;

        flex-direction: column;

        justify-content: center;

    }


    .card h3 {

        font-size: 14px;

    }


    .card p {

        font-size: 11px;

    }

}
CSS


cat > "$PROJECT/js/app.js" <<'JS'
const pages = {
    home: document.getElementById("homePage"),
    category: document.getElementById("categoryPage"),
    detail: document.getElementById("detailPage"),
    all: document.getElementById("allPage")
};


const categoriesContainer =
    document.getElementById("categories");


const featuredContainer =
    document.getElementById("featured");


const categoryItems =
    document.getElementById("categoryItems");


const categoryTitle =
    document.getElementById("categoryTitle");


const categoryEyebrow =
    document.getElementById("categoryEyebrow");


const detailContent =
    document.getElementById("detailContent");


const allArticles =
    document.getElementById("allArticles");


const searchInput =
    document.getElementById("searchInput");


const clearSearch =
    document.getElementById("clearSearch");


const searchResults =
    document.getElementById("searchResults");


const resultsGrid =
    document.getElementById("resultsGrid");


const resultCount =
    document.getElementById("resultCount");


const normalHome =
    document.getElementById("normalHome");


/* =========================
   NAVIGATION
========================= */

function showPage(pageName) {

    Object.values(pages)
        .forEach(page => {

            page.classList.remove("active");

        });


    pages[pageName]
        .classList.add("active");


    document
        .querySelectorAll(".nav-item")
        .forEach(item => {

            item.classList.remove("active");

        });


    const activeNav =
        document.querySelector(
            `.nav-item[data-page="${pageName}"]`
        );


    if (activeNav) {

        activeNav.classList.add("active");

    }


    window.scrollTo({
        top: 0,
        behavior: "smooth"
    });

}


/* =========================
   CATEGORIES
========================= */

function renderCategories() {

    categoriesContainer.innerHTML = "";


    categories.forEach(category => {

        const element =
            document.createElement("button");


        element.className =
            "category";


        element.innerHTML = `

            <div class="category-icon">
                ${category.icon}
            </div>

            <h3>
                ${category.title}
            </h3>

            <p>
                ${category.description}
            </p>

        `;


        element.addEventListener(
            "click",
            () => openCategory(category.id)
        );


        categoriesContainer
            .appendChild(element);

    });

}


/* =========================
   ARTICLE CARD
========================= */

function createCard(article) {

    const element =
        document.createElement("article");


    element.className =
        "card";


    element.innerHTML = `

        <img
            class="card-image"
            src="${article.image}"
            alt="${article.title}"
            loading="lazy"
        >

        <div class="card-body">

            <div class="card-category">
                ${article.category}
            </div>

            <h3>
                ${article.title}
            </h3>

            <p>
                ${article.description}
            </p>

        </div>

    `;


    element.addEventListener(
        "click",
        () => openArticle(article.id)
    );


    return element;

}


/* =========================
   FEATURED
========================= */

function renderFeatured() {

    featuredContainer.innerHTML = "";


    articles
        .slice(0, 3)
        .forEach(article => {

            featuredContainer
                .appendChild(
                    createCard(article)
                );

        });

}


/* =========================
   ALL ARTICLES
========================= */

function renderAllArticles() {

    allArticles.innerHTML = "";


    articles.forEach(article => {

        allArticles
            .appendChild(
                createCard(article)
            );

    });

}


/* =========================
   CATEGORY
========================= */

function openCategory(categoryId) {

    const category =
        categories.find(
            item => item.id === categoryId
        );


    if (!category) return;


    categoryTitle.textContent =
        category.title;


    categoryEyebrow.textContent =
        category.description;


    const items =
        articles.filter(
            article =>
                article.category === categoryId
        );


    categoryItems.innerHTML = "";


    if (items.length === 0) {

        categoryItems.innerHTML = `

            <div class="empty-state">

                <strong>
                    No guides yet
                </strong>

                More content will be added here.

            </div>

        `;

    } else {

        items.forEach(article => {

            categoryItems
                .appendChild(
                    createCard(article)
                );

        });

    }


    showPage("category");

}


/* =========================
   ARTICLE DETAIL
========================= */

function openArticle(id) {

    const article =
        articles.find(
            item => item.id === id
        );


    if (!article) return;


    detailContent.innerHTML = `

        <span class="eyebrow detail-category">
            ${article.category}
        </span>

        <h1>
            ${article.title}
        </h1>

        <img
            class="detail-image"
            src="${article.image}"
            alt="${article.title}"
        >

        <p class="detail-description">
            ${article.description}
        </p>

        ${article.sections
            .map(section => `

                <section
                    class="detail-section"
                >

                    <h2>
                        ${section.title}
                    </h2>

                    <p>
                        ${section.text}
                    </p>

                </section>

            `)
            .join("")}

    `;


    showPage("detail");

}


/* =========================
   SEARCH
========================= */

function search(query) {

    const value =
        query.trim().toLowerCase();


    if (!value) {

        searchResults
            .classList.add("hidden");

        normalHome
            .classList.remove("hidden");

        clearSearch
            .classList.remove("visible");

        return;

    }


    clearSearch
        .classList.add("visible");


    normalHome
        .classList.add("hidden");


    searchResults
        .classList.remove("hidden");


    const results =
        articles.filter(article => {

            return (

                article.title
                    .toLowerCase()
                    .includes(value)

                ||

                article.description
                    .toLowerCase()
                    .includes(value)

                ||

                article.category
                    .toLowerCase()
                    .includes(value)

                ||

                article.sections.some(
                    section =>
                        section.title
                            .toLowerCase()
                            .includes(value)

                        ||

                        section.text
                            .toLowerCase()
                            .includes(value)
                )

            );

        });


    resultCount.textContent =
        results.length;


    resultsGrid.innerHTML = "";


    if (results.length === 0) {

        resultsGrid.innerHTML = `

            <div class="empty-state">

                <strong>
                    Nothing found
                </strong>

                Try another search term.

            </div>

        `;

        return;

    }


    results.forEach(article => {

        resultsGrid
            .appendChild(
                createCard(article)
            );

    });

}


searchInput.addEventListener(
    "input",
    event => {

        search(event.target.value);

    }
);


/* =========================
   CLEAR SEARCH
========================= */

clearSearch.addEventListener(
    "click",
    () => {

        searchInput.value = "";

        search("");

        searchInput.focus();

    }
);


/* =========================
   HEADER SEARCH
========================= */

document
    .getElementById("headerSearchButton")
    .addEventListener(
        "click",
        () => {

            showPage("home");

            searchInput.focus();

            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });

        }
    );


/* =========================
   BACK BUTTONS
========================= */

document
    .getElementById("backButton")
    .addEventListener(
        "click",
        () => showPage("home")
    );


document
    .getElementById("categoryBackButton")
    .addEventListener(
        "click",
        () => showPage("home")
    );


/* =========================
   VIEW ALL
========================= */

document
    .getElementById("viewAllButton")
    .addEventListener(
        "click",
        () => showPage("all")
    );


/* =========================
   BOTTOM NAV
========================= */

document
    .querySelectorAll(".nav-item")
    .forEach(item => {

        item.addEventListener(
            "click",
            () => {

                const target =
                    item.dataset.page;


                if (target === "categories") {

                    showPage("home");


                    setTimeout(() => {

                        document
                            .getElementById("categories")
                            .scrollIntoView({
                                behavior: "smooth"
                            });

                    }, 50);


                    return;

                }


                showPage(target);

            }
        );

    });


/* =========================
   MENU
========================= */

document
    .getElementById("menuButton")
    .addEventListener(
        "click",
        () => {

            alert(
                "Menu will be added here."
            );

        }
    );


/* =========================
   INITIALIZE
========================= */

renderCategories();

renderFeatured();

renderAllArticles();
JS


cat > "$PROJECT/js/data.js" <<'JS'
const categories = [

    {
        id: "characters",
        title: "Characters",
        description: "Characters, abilities and builds.",
        icon: "◈"
    },

    {
        id: "weapons",
        title: "Weapons",
        description: "Weapons, stats and information.",
        icon: "⚔"
    },

    {
        id: "bosses",
        title: "Bosses",
        description: "Boss strategies and weaknesses.",
        icon: "☠"
    },

    {
        id: "items",
        title: "Items",
        description: "Resources and collectibles.",
        icon: "◆"
    },

    {
        id: "maps",
        title: "Maps",
        description: "Locations and important areas.",
        icon: "⌖"
    },

    {
        id: "tips",
        title: "Tips",
        description: "Useful tricks and secrets.",
        icon: "!"
    }

];


const articles = [

    {
        id: 1,

        category: "bosses",

        title: "Fire Dragon",

        image: "images/fire-dragon.jpg.svg",

        description:
            "Everything you need to know about defeating the Fire Dragon.",

        sections: [

            {
                title: "Weakness",

                text:
                    "The Fire Dragon is highly vulnerable to ice-based attacks."
            },

            {
                title: "Strategy",

                text:
                    "Keep your distance and avoid standing directly in front of the boss."
            },

            {
                title: "Recommended Gear",

                text:
                    "Use high fire resistance and an ice weapon."
            }

        ]

    },


    {
        id: 2,

        category: "weapons",

        title: "Ancient Sword",

        image: "images/ancient-sword.jpg.svg",

        description:
            "A powerful sword with high damage and excellent range.",

        sections: [

            {
                title: "Stats",

                text:
                    "Damage: 95. Speed: 72. Range: 80."
            },

            {
                title: "How to obtain",

                text:
                    "Found inside the Ancient Ruins."
            }

        ]

    },


    {
        id: 3,

        category: "characters",

        title: "The Hunter",

        image: "images/hunter.jpg.svg",

        description:
            "A ranged character focused on mobility and critical attacks.",

        sections: [

            {
                title: "Playstyle",

                text:
                    "Keep your distance and use mobility to avoid enemy attacks."
            },

            {
                title: "Best Build",

                text:
                    "Focus on critical chance, ranged damage and movement speed."
            }

        ]

    }

];
JS


echo
echo "=========================================="
echo " Game Guide UI updated successfully!"
echo "=========================================="
echo
echo "Run:"
echo
echo "  cd $PROJECT"
echo "  python3 -m http.server 8080"
echo
echo "Then open:"
echo
echo "  http://localhost:8080"
echo

