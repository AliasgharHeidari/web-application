#!/usr/bin/env bash

set -e

PROJECT="game-guide"

mkdir -p "$PROJECT"/{css,js,images}


# ============================================================
# index.html
# ============================================================

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

<div class="app">


    <!-- ======================================================
         HEADER
    ======================================================= -->

    <header class="topbar">

        <button
            id="menuButton"
            class="icon-button"
            aria-label="Open menu"
        >
            ☰
        </button>


        <div class="brand">

            <span class="brand-mark">◆</span>

            <span>GAME GUIDE</span>

        </div>


        <button
            id="headerSearchButton"
            class="icon-button"
            aria-label="Search"
        >
            ⌕
        </button>

    </header>



    <!-- ======================================================
         SIDE MENU
    ======================================================= -->

    <div
        id="menuOverlay"
        class="menu-overlay"
    ></div>


    <aside
        id="sideMenu"
        class="side-menu"
    >

        <div class="menu-header">

            <div class="menu-brand">

                <span class="brand-mark">
                    ◆
                </span>

                <span>
                    GAME GUIDE
                </span>

            </div>


            <button
                id="closeMenu"
                class="icon-button"
                aria-label="Close menu"
            >
                ×
            </button>

        </div>


        <nav class="menu-links">


            <button
                class="menu-link active"
                data-menu="home"
            >

                <span>⌂</span>

                <span>Home</span>

            </button>


            <button
                class="menu-link"
                data-menu="categories"
            >

                <span>▦</span>

                <span>Categories</span>

            </button>


            <button
                class="menu-link"
                data-menu="guides"
            >

                <span>☰</span>

                <span>All Guides</span>

            </button>


            <div class="menu-divider"></div>


            <button
                class="menu-link"
                data-menu="about"
            >

                <span>ⓘ</span>

                <span>About</span>

            </button>


            <button
                class="menu-link"
                data-menu="settings"
            >

                <span>⚙</span>

                <span>Settings</span>

            </button>


        </nav>


        <div class="menu-footer">

            <span>GAME GUIDE</span>

            <span>v1.0.0</span>

        </div>

    </aside>



    <!-- ======================================================
         MAIN
    ======================================================= -->

    <main>


        <!-- ==================================================
             HOME
        =================================================== -->

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

                    <div class="section-header">

                        <h2>
                            Search results
                        </h2>

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

                            <button
                                class="text-button"
                                id="categoriesViewAll"
                            >
                                View all
                            </button>

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
                                class="text-button"
                                id="viewAllButton"
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



        <!-- ==================================================
             CATEGORY PAGE
        =================================================== -->

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



        <!-- ==================================================
             ALL GUIDES
        =================================================== -->

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



        <!-- ==================================================
             DETAIL
        =================================================== -->

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



        <!-- ==================================================
             ABOUT
        =================================================== -->

        <section
            id="aboutPage"
            class="page"
        >

            <div class="page-content">

                <div class="page-heading">

                    <span class="eyebrow">
                        INFORMATION
                    </span>

                    <h1>
                        About
                    </h1>

                </div>


                <div class="info-card">

                    <div class="info-icon">
                        ◆
                    </div>


                    <h2>
                        Game Guide
                    </h2>


                    <p>
                        A simple offline guide designed to
                        help you quickly find information
                        about the game.
                    </p>


                    <div class="info-row">

                        <span>
                            Version
                        </span>

                        <strong>
                            1.0.0
                        </strong>

                    </div>


                    <div class="info-row">

                        <span>
                            Content
                        </span>

                        <strong>
                            Offline
                        </strong>

                    </div>


                </div>

            </div>

        </section>



        <!-- ==================================================
             SETTINGS
        =================================================== -->

        <section
            id="settingsPage"
            class="page"
        >

            <div class="page-content">

                <div class="page-heading">

                    <span class="eyebrow">
                        APP
                    </span>

                    <h1>
                        Settings
                    </h1>

                </div>


                <div class="settings-list">


                    <div class="setting">

                        <div>

                            <strong>
                                Dark Mode
                            </strong>

                            <span>
                                Use the dark interface
                            </span>

                        </div>


                        <label class="switch">

                            <input
                                id="darkModeToggle"
                                type="checkbox"
                                checked
                            >

                            <span></span>

                        </label>

                    </div>



                    <div class="setting">

                        <div>

                            <strong>
                                Animations
                            </strong>

                            <span>
                                Enable interface animations
                            </span>

                        </div>


                        <label class="switch">

                            <input
                                id="animationToggle"
                                type="checkbox"
                                checked
                            >

                            <span></span>

                        </label>

                    </div>


                </div>

            </div>

        </section>


    </main>



    <!-- ======================================================
         BOTTOM NAV
    ======================================================= -->

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
            data-page="guides"
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



# ============================================================
# CSS
# ============================================================

cat > "$PROJECT/css/style.css" <<'CSS'
:root {

    --background: #0d0e12;
    --surface: #14151a;
    --surface-hover: #1a1c22;

    --border: #24262d;

    --text: #f2f3f5;
    --muted: #8d919b;

    --accent: #ffffff;

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

    padding-bottom: 70px;

}


/* =========================================================
   TOP BAR
========================================================= */

.topbar {

    height: 62px;

    display: grid;

    grid-template-columns:
        45px
        1fr
        45px;

    align-items: center;

    position: sticky;

    top: 0;

    z-index: 100;

    padding: 0 12px;

    background:
        rgba(13,14,18,.94);

    border-bottom:
        1px solid var(--border);

    backdrop-filter:
        blur(16px);

}


.brand {

    display: flex;

    align-items: center;

    justify-content: center;

    gap: 8px;

    font-size: 12px;

    font-weight: 800;

    letter-spacing: 1.7px;

}


.brand-mark {

    font-size: 10px;

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


.icon-button:hover {

    background:
        rgba(255,255,255,.05);

}


/* =========================================================
   SIDE MENU
========================================================= */

.menu-overlay {

    position: fixed;

    inset: 0;

    z-index: 300;

    background:
        rgba(0,0,0,.58);

    opacity: 0;

    visibility: hidden;

    transition:
        opacity .22s,
        visibility .22s;

}


.menu-overlay.open {

    opacity: 1;

    visibility: visible;

}


.side-menu {

    position: fixed;

    top: 0;

    left: 0;

    bottom: 0;

    z-index: 400;

    width: min(310px, 84vw);

    display: flex;

    flex-direction: column;

    background: #111217;

    border-right:
        1px solid var(--border);

    transform:
        translateX(-100%);

    transition:
        transform .25s ease;

}


.side-menu.open {

    transform:
        translateX(0);

}


.menu-header {

    height: 62px;

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 0 12px 0 20px;

    border-bottom:
        1px solid var(--border);

}


.menu-brand {

    display: flex;

    align-items: center;

    gap: 9px;

    font-size: 12px;

    font-weight: 800;

    letter-spacing: 1.6px;

}


.menu-links {

    padding: 15px 10px;

}


.menu-link {

    width: 100%;

    height: 48px;

    display: flex;

    align-items: center;

    gap: 13px;

    padding: 0 13px;

    margin-bottom: 4px;

    border-radius: 10px;

    background: transparent;

    color: var(--muted);

    text-align: left;

    font-size: 13px;

}


.menu-link > span:first-child {

    width: 25px;

    text-align: center;

    font-size: 17px;

}


.menu-link:hover {

    background:
        rgba(255,255,255,.04);

    color: var(--text);

}


.menu-link.active {

    background:
        rgba(255,255,255,.07);

    color: var(--text);

}


.menu-divider {

    height: 1px;

    margin: 12px 5px;

    background: var(--border);

}


.menu-footer {

    margin-top: auto;

    padding: 20px;

    display: flex;

    justify-content: space-between;

    color: #686c75;

    font-size: 9px;

    letter-spacing: 1.5px;

    border-top:
        1px solid var(--border);

}


/* =========================================================
   PAGES
========================================================= */

.page {

    display: none;

}


.page.active {

    display: block;

}


.home-content,
.page-content,
.detail-page {

    width:
        min(
            calc(100% - 28px),
            1050px
        );

    margin: auto;

}


.home-content {

    padding-top: 18px;

}


.page-content {

    padding-top: 25px;

    padding-bottom: 40px;

}


.detail-page {

    padding-top: 20px;

    padding-bottom: 60px;

}


/* =========================================================
   SEARCH
========================================================= */

.search-box {

    height: 50px;

    display: flex;

    align-items: center;

    gap: 10px;

    padding: 0 14px;

    background: var(--surface);

    border:
        1px solid var(--border);

    border-radius: 12px;

}


.search-box:focus-within {

    border-color: #444751;

}


.search-icon {

    color: var(--muted);

    font-size: 20px;

}


.search-box input {

    flex: 1;

    min-width: 0;

    height: 100%;

    outline: none;

    border: 0;

    background: transparent;

    color: var(--text);

}


.search-box input::placeholder {

    color: #6f737d;

}


.clear-search {

    display: none;

    width: 27px;

    height: 27px;

    border-radius: 50%;

    background: #24262d;

    color: var(--muted);

}


.clear-search.visible {

    display: block;

}


/* =========================================================
   SECTIONS
========================================================= */

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

}


.text-button {

    background: transparent;

    color: var(--muted);

    font-size: 12px;

}


.text-button:hover {

    color: var(--text);

}


.muted {

    color: var(--muted);

    font-size: 12px;

}


/* =========================================================
   CATEGORY
========================================================= */

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

    color: var(--text);

    border:
        1px solid var(--border);

    border-radius: var(--radius);

    text-align: left;

    transition:
        transform .15s,
        background .15s;

}


.category:hover {

    background:
        var(--surface-hover);

}


.category:active {

    transform:
        scale(.98);

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


/* =========================================================
   CARDS
========================================================= */

.card-grid {

    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 12px;

}


.card {

    overflow: hidden;

    background: var(--surface);

    border:
        1px solid var(--border);

    border-radius: var(--radius);

    transition:
        transform .15s,
        background .15s;

}


.card:hover {

    background:
        var(--surface-hover);

}


.card:active {

    transform:
        scale(.985);

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


/* =========================================================
   PAGE HEADING
========================================================= */

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


/* =========================================================
   BACK BUTTON
========================================================= */

.back-button {

    display: inline-flex;

    align-items: center;

    gap: 6px;

    margin-bottom: 24px;

    padding: 9px 13px;

    background: var(--surface);

    color: var(--text);

    border:
        1px solid var(--border);

    border-radius: 9px;

    font-size: 12px;

}


/* =========================================================
   DETAIL
========================================================= */

.detail-category {

    display: block;

    margin-bottom: 7px;

}


.detail-page h1 {

    margin: 0 0 18px;

    font-size:
        clamp(30px, 6vw, 48px);

    line-height: 1.05;

}


.detail-image {

    width: 100%;

    display: block;

    aspect-ratio: 16 / 8;

    object-fit: cover;

    border-radius: var(--radius);

    border:
        1px solid var(--border);

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

    border-top:
        1px solid var(--border);

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


/* =========================================================
   INFO / ABOUT
========================================================= */

.info-card {

    padding: 25px;

    background: var(--surface);

    border:
        1px solid var(--border);

    border-radius: var(--radius);

}


.info-icon {

    width: 45px;

    height: 45px;

    display: flex;

    align-items: center;

    justify-content: center;

    margin-bottom: 18px;

    border-radius: 12px;

    background: #1d1f25;

}


.info-card h2 {

    margin: 0 0 10px;

}


.info-card > p {

    margin: 0 0 25px;

    color: var(--muted);

    line-height: 1.7;

}


.info-row {

    display: flex;

    justify-content: space-between;

    padding: 14px 0;

    border-top:
        1px solid var(--border);

    color: var(--muted);

    font-size: 13px;

}


.info-row strong {

    color: var(--text);

}


/* =========================================================
   SETTINGS
========================================================= */

.settings-list {

    overflow: hidden;

    background: var(--surface);

    border:
        1px solid var(--border);

    border-radius: var(--radius);

}


.setting {

    display: flex;

    align-items: center;

    justify-content: space-between;

    gap: 20px;

    padding: 18px;

}


.setting + .setting {

    border-top:
        1px solid var(--border);

}


.setting strong {

    display: block;

    margin-bottom: 5px;

    font-size: 14px;

}


.setting span {

    color: var(--muted);

    font-size: 11px;

}


/* =========================================================
   SWITCH
========================================================= */

.switch {

    position: relative;

    width: 42px;

    height: 24px;

    flex-shrink: 0;

}


.switch input {

    display: none;

}


.switch span {

    position: absolute;

    inset: 0;

    border-radius: 20px;

    background: #292b32;

    transition: .2s;

}


.switch span::after {

    content: "";

    position: absolute;

    width: 18px;

    height: 18px;

    top: 3px;

    left: 3px;

    border-radius: 50%;

    background: #858993;

    transition: .2s;

}


.switch input:checked + span {

    background: #e7e8eb;

}


.switch input:checked + span::after {

    transform:
        translateX(18px);

    background: #17181d;

}


/* =========================================================
   BOTTOM NAV
========================================================= */

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

    background:
        rgba(17,18,23,.96);

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

}


.nav-item.active {

    color: var(--text);

}


.nav-icon {

    font-size: 18px;

    line-height: 20px;

}


/* =========================================================
   SEARCH
========================================================= */

.hidden {

    display: none !important;

}


.empty-state {

    grid-column: 1 / -1;

    padding: 50px 20px;

    text-align: center;

    color: var(--muted);

}


.empty-state strong {

    display: block;

    margin-bottom: 7px;

    color: var(--text);

}


/* =========================================================
   NO ANIMATIONS
========================================================= */

.no-animations *,
.no-animations *::before,
.no-animations *::after {

    transition: none !important;

    animation: none !important;

}


/* =========================================================
   RESPONSIVE
========================================================= */

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

        min-height: 110px;

        aspect-ratio: auto;

    }


    .card-body {

        display: flex;

        flex-direction: column;

        justify-content: center;

    }

}
CSS



# ============================================================
# DATA
# ============================================================

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



# ============================================================
# JAVASCRIPT
# ============================================================

cat > "$PROJECT/js/app.js" <<'JS'
const pages = {

    home:
        document.getElementById("homePage"),

    category:
        document.getElementById("categoryPage"),

    guides:
        document.getElementById("allPage"),

    detail:
        document.getElementById("detailPage"),

    about:
        document.getElementById("aboutPage"),

    settings:
        document.getElementById("settingsPage")

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


const sideMenu =
    document.getElementById("sideMenu");


const menuOverlay =
    document.getElementById("menuOverlay");


const menuButton =
    document.getElementById("menuButton");


const closeMenu =
    document.getElementById("closeMenu");



/* =========================================================
   PAGE NAVIGATION
========================================================= */

function showPage(name) {

    Object.values(pages)
        .forEach(page => {

            page.classList.remove("active");

        });


    const page = pages[name];


    if (!page) return;


    page.classList.add("active");


    updateNavigation(name);


    window.scrollTo({

        top: 0,

        behavior: "smooth"

    });

}


/* =========================================================
   BOTTOM NAVIGATION
========================================================= */

function updateNavigation(name) {

    document
        .querySelectorAll(".nav-item")
        .forEach(item => {

            item.classList.remove("active");

        });


    let navName = name;


    if (name === "category") {

        navName = "categories";

    }


    const nav =
        document.querySelector(
            `.nav-item[data-page="${navName}"]`
        );


    if (nav) {

        nav.classList.add("active");

    }

}


/* =========================================================
   SIDE MENU
========================================================= */

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


menuButton.addEventListener(
    "click",
    openMenu
);


closeMenu.addEventListener(
    "click",
    closeSideMenu
);


menuOverlay.addEventListener(
    "click",
    closeSideMenu
);



/* =========================================================
   MENU ITEMS
========================================================= */

document
    .querySelectorAll(".menu-link")
    .forEach(item => {

        item.addEventListener(
            "click",
            () => {

                const target =
                    item.dataset.menu;


                document
                    .querySelectorAll(".menu-link")
                    .forEach(link => {

                        link.classList.remove("active");

                    });


                item.classList.add("active");


                closeSideMenu();


                if (target === "categories") {

                    showPage("home");


                    setTimeout(() => {

                        document
                            .getElementById("categories")
                            .scrollIntoView({

                                behavior: "smooth",

                                block: "start"

                            });

                    }, 80);


                    return;

                }


                showPage(target);

            }
        );

    });



/* =========================================================
   CATEGORIES
========================================================= */

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


/* =========================================================
   CARD
========================================================= */

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


/* =========================================================
   FEATURED
========================================================= */

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


/* =========================================================
   ALL ARTICLES
========================================================= */

function renderAllArticles() {

    allArticles.innerHTML = "";


    if (!articles.length) {

        allArticles.innerHTML = `

            <div class="empty-state">

                <strong>
                    No guides available
                </strong>

                Add guides to data.js.

            </div>

        `;

        return;

    }


    articles.forEach(article => {

        allArticles
            .appendChild(
                createCard(article)
            );

    });

}


/* =========================================================
   CATEGORY
========================================================= */

function openCategory(categoryId) {

    const category =
        categories.find(
            item =>
                item.id === categoryId
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


    if (!items.length) {

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


/* =========================================================
   ARTICLE
========================================================= */

function openArticle(id) {

    const article =
        articles.find(
            item => item.id === id
        );


    if (!article) return;


    detailContent.innerHTML = `

        <span
            class="eyebrow detail-category"
        >
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


/* =========================================================
   SEARCH
========================================================= */

function search(query) {

    const value =
        query
            .trim()
            .toLowerCase();


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


    if (!results.length) {

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
    event =>
        search(event.target.value)
);



/* =========================================================
   CLEAR SEARCH
========================================================= */

clearSearch.addEventListener(
    "click",
    () => {

        searchInput.value = "";

        search("");

        searchInput.focus();

    }
);



/* =========================================================
   HEADER SEARCH
========================================================= */

document
    .getElementById("headerSearchButton")
    .addEventListener(
        "click",
        () => {

            showPage("home");

            searchInput.focus();

        }
    );



/* =========================================================
   BACK
========================================================= */

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



/* =========================================================
   VIEW ALL
========================================================= */

document
    .getElementById("viewAllButton")
    .addEventListener(
        "click",
        () => showPage("guides")
    );


document
    .getElementById("categoriesViewAll")
    .addEventListener(
        "click",
        () => {

            showPage("home");


            setTimeout(() => {

                document
                    .getElementById("categories")
                    .scrollIntoView({

                        behavior: "smooth"

                    });

            }, 80);

        }
    );



/* =========================================================
   BOTTOM NAV
========================================================= */

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

                                behavior: "smooth",

                                block: "start"

                            });

                    }, 80);


                    return;

                }


                showPage(target);

            }
        );

    });



/* =========================================================
   DARK MODE
========================================================= */

document
    .getElementById("darkModeToggle")
    .addEventListener(
        "change",
        event => {

            document.body.classList.toggle(
                "light-mode",
                !event.target.checked
            );

        }
    );



/* =========================================================
   ANIMATIONS
========================================================= */

document
    .getElementById("animationToggle")
    .addEventListener(
        "change",
        event => {

            document.body.classList.toggle(
                "no-animations",
                !event.target.checked
            );

        }
    );



/* =========================================================
   INITIALIZE
========================================================= */

renderCategories();

renderFeatured();

renderAllArticles();

JS



# ============================================================
# LIGHT MODE ADDITION
# ============================================================

cat >> "$PROJECT/css/style.css" <<'CSS'

/* =========================================================
   LIGHT MODE
========================================================= */

body.light-mode {

    --background: #f4f5f7;

    --surface: #ffffff;

    --surface-hover: #f0f1f3;

    --border: #dfe1e6;

    --text: #15161a;

    --muted: #666b75;

}


body.light-mode .topbar {

    background:
        rgba(244,245,247,.94);

}


body.light-mode .side-menu {

    background: #ffffff;

}


body.light-mode .bottom-nav {

    background:
        rgba(255,255,255,.96);

}


body.light-mode .category-icon {

    background: #f0f1f3;

}


body.light-mode .search-box input {

    color: #15161a;

}


body.light-mode .card p,
body.light-mode .detail-description,
body.light-mode .detail-section p {

    color: #666b75;

}


body.light-mode .switch input:checked + span {

    background: #202126;

}


body.light-mode .switch input:checked + span::after {

    background: #ffffff;

}


@media (max-width: 480px) {

    .home-content,
    .page-content,
    .detail-page {

        width:
            calc(100% - 20px);

    }

}
CSS



# ============================================================
# PLACEHOLDER IMAGES
# ============================================================

cat > "$PROJECT/images/fire-dragon.jpg.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="675">
<rect width="100%" height="100%" fill="#181a20"/>
<text x="50%" y="48%" fill="#ffffff" font-size="52" font-family="Arial" text-anchor="middle">FIRE DRAGON</text>
<text x="50%" y="58%" fill="#858993" font-size="24" font-family="Arial" text-anchor="middle">Boss Guide</text>
</svg>
SVG


cat > "$PROJECT/images/ancient-sword.jpg.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="675">
<rect width="100%" height="100%" fill="#181a20"/>
<text x="50%" y="48%" fill="#ffffff" font-size="52" font-family="Arial" text-anchor="middle">ANCIENT SWORD</text>
<text x="50%" y="58%" fill="#858993" font-size="24" font-family="Arial" text-anchor="middle">Weapon Guide</text>
</svg>
SVG


cat > "$PROJECT/images/hunter.jpg.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="675">
<rect width="100%" height="100%" fill="#181a20"/>
<text x="50%" y="48%" fill="#ffffff" font-size="52" font-family="Arial" text-anchor="middle">THE HUNTER</text>
<text x="50%" y="58%" fill="#858993" font-size="24" font-family="Arial" text-anchor="middle">Character Guide</text>
</svg>
SVG



echo
echo "=========================================="
echo " Game Guide rebuilt successfully!"
echo "=========================================="
echo
echo "Features:"
echo "  ✓ Side menu"
echo "  ✓ Home"
echo "  ✓ Categories"
echo "  ✓ All Guides"
echo "  ✓ Search"
echo "  ✓ Article details"
echo "  ✓ About"
echo "  ✓ Settings"
echo "  ✓ Dark / Light mode"
echo "  ✓ Animation toggle"
echo "  ✓ Mobile bottom navigation"
echo "  ✓ Responsive layout"
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

