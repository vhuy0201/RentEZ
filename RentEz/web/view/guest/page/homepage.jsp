<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>RentEz - Home Page</title>

    <link
      rel="shortcut icon"
      href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"
    />

    <!-- Bootstrap -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"
    />
    <!-- Font awesome -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"
    />
    <!-- line awesome -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"
    />

<!--    <script
      type="module"
      crossorigin=""
      src="${pageContext.request.contextPath}/view/guest/asset/js/index-Br3lXc3e.js"
    ></script>-->
    <link
      rel="stylesheet"
      crossorigin=""
      href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"
    />
  </head>
  <body class="">
    <div id="root">
      <main class="body-bg">
        <header class="header">
          <div class="container container-two">
            <nav class="header-inner flx-between">
              <div class="logo">
                <a class="link" href="https://cityscape.wowtheme7.com/"
                  ><img
                    src="${pageContext.request.contextPath}/view/guest/asset/img/logo-DHG6Mbuc.png"
                    alt="Logo"
                /></a>
              </div>
              <div class="header-menu d-lg-block d-none">
                <ul class="nav-menu flx-align">
                  <li class="nav-menu__item has-submenu activePage">
                    <a
                      aria-current="page"
                      class="nav-menu__link active"
                      href="https://cityscape.wowtheme7.com/"
                      >Home</a
                    >
                    <ul class="nav-submenu">
                      <li class="nav-submenu__item activePage">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/"
                          >Home One</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/home-two"
                          >Home Two</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/home-three"
                          >Home Three</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/home-four"
                          >Home Four</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/home-five"
                          >Home Five</a
                        >
                      </li>
                    </ul>
                  </li>
                  <li class="nav-menu__item has-submenu">
                    <a
                      aria-current="page"
                      class="nav-menu__link active"
                      href="https://cityscape.wowtheme7.com/"
                      >Pages</a
                    >
                    <ul class="nav-submenu">
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/property"
                          >Property</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/property-sidebar"
                          >Property Sidebar</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/add-new-listing"
                          >Add New Listing</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/map-location"
                          >Map Location</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/about-us"
                          >About Us</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/faq"
                          >Faq</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/cart"
                          >Cart</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/checkout"
                          >Checkout</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/login"
                          >Login</a
                        >
                      </li>
                      <li class="nav-submenu__item">
                        <a
                          class="nav-submenu__link"
                          href="https://cityscape.wowtheme7.com/account"
                          >Account</a
                        >
                      </li>
                    </ul>
                  </li>
                  <li class="nav-menu__item">
                    <a
                      class="nav-menu__link"
                      href="https://cityscape.wowtheme7.com/project"
                      >Project</a
                    >
                  </li>
                  <li class="nav-menu__item">
                    <a
                      class="nav-menu__link"
                      href="https://cityscape.wowtheme7.com/blog"
                      >Blog</a
                    >
                  </li>
                  <li class="nav-menu__item">
                    <a
                      class="nav-menu__link"
                      href="https://cityscape.wowtheme7.com/contact"
                      >Contact</a
                    >
                  </li>
                </ul>
              </div>
              <div class="header-right flx-align">
                  <a
                  class="btn btn btn-outline-light d-lg-block d-none"
                  href="https://cityscape.wowtheme7.com/property"
                  >Sell Property<span class="icon icon-right text-gradient">
                    <i class="fas fa-arrow-right"></i> </span></a
                ><button type="button" class="toggle-mobileMenu d-lg-none ms-3">
                  <i class="las la-bars"></i>
                </button>
              </div>
            </nav>
          </div>
        </header>
        <section class="banner">
          <div class="container container-two">
            <div class="position-relative">
              <div class="row">
                <div class="col-lg-6">
                  <div class="banner-inner position-relative">
                    <div class="banner-content">
                      <span
                        class="banner-content__subtitle text-uppercase font-14"
                      >
                        FinTech Fusion
                      </span>
                      <h1 class="banner-content__title">
                        Invest today in You
                        <span class="text-gradient">Dream Home</span>
                      </h1>
                      <p class="banner-content__desc font-18">
                        Unlock the Power of Real Estate Making Your Real Estate
                        Dreams a Reality Real Estate here Unlock the Power of
                        Real Estate
                      </p>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 order-lg-0 order-1">
                  <div class="banner-thumb">
                    <img
                      src="${pageContext.request.contextPath}/view/guest/asset/img/banner-img-C9N0pCHn.png"
                      alt=""
                    /><img
                      src="${pageContext.request.contextPath}/view/guest/asset/img/shape-triangle.png"
                      alt=""
                      class="shape-element one"
                    /><img
                      src="${pageContext.request.contextPath}/view/guest/asset/img/shape-circle.png"
                      alt=""
                      class="shape-element two"
                    /><img
                      src="${pageContext.request.contextPath}/view/guest/asset/img/shape-moon.png"
                      alt=""
                      class="shape-element three"
                    />
                  </div>
                </div>
                <div class="col-lg-12">
                  <div class="react-tabs" data-rttabs="true">
                    <ul class="common-tab nav nav-pills" role="tablist">
                      <li
                        class="nav-link react-tabs__tab--selected"
                        role="tab"
                        id="tab:r7:0"
                        aria-selected="true"
                        aria-disabled="false"
                        aria-controls="panel:r7:0"
                        tabindex="0"
                        data-rttab="true"
                      >
                        Rent
                      </li>
                      <li
                        class="nav-link"
                        role="tab"
                        id="tab:r7:1"
                        aria-selected="false"
                        aria-disabled="false"
                        aria-controls="panel:r7:1"
                        data-rttab="true"
                      >
                        Buy
                      </li>
                      <li
                        class="nav-link"
                        role="tab"
                        id="tab:r7:2"
                        aria-selected="false"
                        aria-disabled="false"
                        aria-controls="panel:r7:2"
                        data-rttab="true"
                      >
                        Sell
                      </li>
                    </ul>
                    <div
                      class="react-tabs__tab-panel react-tabs__tab-panel--selected"
                      role="tabpanel"
                      id="panel:r7:0"
                      aria-labelledby="tab:r7:0"
                    >
                      <div class="Toastify"></div>
                      <div class="filter">
                        <form action="https://cityscape.wowtheme7.com/#">
                          <div class="row gy-sm-4 gy-3">
                            <div class="col-lg-3 col-sm-6 col-xs-6">
                              <input
                                type="text"
                                placeholder="Enter Keyword"
                                name="searchKeyword"
                                id="name"
                                class="common-input"
                                value=""
                              />
                            </div>
                            <div class="col-lg-3 col-sm-6 col-xs-6">
                              <div class="select-has-icon icon-black">
                                <select class="select common-input">
                                  <option value="Type" disabled="">Type</option>
                                  <option value="All">All</option>
                                  <option value="Houses">Houses</option>
                                  <option value="Apartments">Apartments</option>
                                  <option value="Office">Office</option>
                                  <option value="Villa">Villa</option>
                                </select>
                              </div>
                            </div>
                            <div class="col-lg-3 col-sm-6 col-xs-6">
                              <div class="select-has-icon icon-black">
                                <select class="select common-input">
                                  <option value="Location" disabled="">
                                    Location
                                  </option>
                                  <option value="All">Country</option>
                                  <option
                                    value="Bangladesh"
                                    data-location="Bangladesh"
                                  >
                                    Bangladesh
                                  </option>
                                  <option value="Japan" data-location="Japan">
                                    Japan
                                  </option>
                                  <option value="Korea" data-location="Korea">
                                    Korea
                                  </option>
                                  <option
                                    value="Singapore"
                                    data-location="Singapore"
                                  >
                                    Singapore
                                  </option>
                                  <option
                                    value="Germany"
                                    data-location="Germany"
                                  >
                                    Germany
                                  </option>
                                  <option
                                    value="Thailand"
                                    data-location="Thailand"
                                  >
                                    Thailand
                                  </option>
                                </select>
                              </div>
                            </div>
                            <div class="col-lg-3 col-sm-6 col-xs-6">
                              <button type="submit" class="btn btn-main w-100">
                                Rent
                              </button>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                    <div
                      class="react-tabs__tab-panel"
                      role="tabpanel"
                      id="panel:r7:1"
                      aria-labelledby="tab:r7:1"
                    ></div>
                    <div
                      class="react-tabs__tab-panel"
                      role="tabpanel"
                      id="panel:r7:2"
                      aria-labelledby="tab:r7:2"
                    ></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="about padding-y-120">
          <div class="container container-two">
            <div class="row gy-4 align-items-center">
              <div class="col-lg-6">
                <div class="about-thumb">
                  <img
                    src="${pageContext.request.contextPath}/view/guest/asset/img/about-img-Bvhtdgfl.png"
                    alt=""
                  />
                  <div class="client-statistics flx-align">
                    <span class="client-statistics__icon"
                      ><i class="fas fa-users text-gradient"></i
                    ></span>
                    <div class="client-statistics__content">
                      <h5 class="client-statistics__number statisticsCounter">
                        <span>4,000</span>
                      </h5>
                      <span class="client-statistics__text fs-18"
                        >Satisfied Clients</span
                      >
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-6">
                <div class="about-content">
                  <div class="section-heading style-left">
                    <div class="section-heading__inner">
                      <span class="section-heading__subtitle"
                        ><span class="text-gradient fw-semibold">
                          About Us
                        </span></span
                      >
                      <h2 class="section-heading__title">
                        Stay with us feel at home Your perfect stay awaits
                      </h2>
                    </div>
                  </div>
                  <div class="about-box d-flex">
                    <div class="about-box__icon">
                      <img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/about-icon-B0EE1wab.svg"
                        alt=""
                      />
                    </div>
                    <div class="about-box__content">
                      <h6 class="about-box__title">Your Dream Home Awaits</h6>
                      <p class="about-box__desc font-13">
                        Real Estate is a vast industry that deals with the
                        buying, selling, and renting of properties. It inv
                        transactions related to residential, commercial, and
                        industrial properties
                      </p>
                    </div>
                  </div>
                  <div class="about-button">
                    <a
                      class="btn btn-main"
                      href="https://cityscape.wowtheme7.com/about-us"
                      >Learn More<span class="icon icon-right">
                        <i class="fas fa-arrow-right"></i> </span
                    ></a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="property padding-y-120">
          <div class="container container-two">
            <div
              class="section-heading style-left style-dark flx-between align-items-end gap-3"
            >
              <div class="section-heading__inner">
                <span class="section-heading__subtitle"
                  ><span class="text-gradient fw-semibold">
                    Latest property
                  </span></span
                >
                <h2 class="section-heading__title">
                  Prestige Property Management property for you
                </h2>
              </div>
              <a
                class="btn btn-main"
                href="https://cityscape.wowtheme7.com/property"
                >View More<span class="icon icon-right">
                  <i class="fas fa-arrow-right"></i> </span
              ></a>
            </div>
            <div class="row gy-4 property-item-wrapper">
              <div class="col-lg-4 col-sm-6">
                <div
                  class="property-item"
                  datastatus="Sell"
                  datatype="Houses"
                  datalocation="Bangladesh"
                  datasort="Newest"
                >
                  <div class="property-item__thumb">
                    <a
                      class="link"
                      href="https://cityscape.wowtheme7.com/property/turning-dreams-into-addresses-home-state-"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/property-1-D5t-zcgy.png"
                        alt=""
                        class="cover-img"
                    /></a>
                  </div>
                  <div class="property-item__content">
                    <h6 class="property-item__price">
                      $300.00<span class="day">/per day</span>
                    </h6>
                    <h6 class="property-item__title">
                      <a
                        class="link"
                        href="https://cityscape.wowtheme7.com/property/turning-dreams-into-addresses-home-state-"
                        >Turning Dreams into Addresses Home State
                      </a>
                    </h6>
                    <p class="property-item__location d-flex gap-2">
                      <span class="icon">
                        <i class="fas fa-map-marker-alt"></i></span
                      >66 Broklyant, New York America
                    </p>
                    <div class="property-item__bottom flx-between gap-2">
                      <ul class="amenities-list flx-align">
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bed"></i></span
                          ><span class="text">2 Beds</span>
                        </li>
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bath"></i></span
                          ><span class="text"> 1 Baths </span>
                        </li>
                      </ul>
                      <a
                        class="simple-btn"
                        href="https://cityscape.wowtheme7.com/property/turning-dreams-into-addresses-home-state-"
                        >Book Now<span class="icon-right">
                          <i class="fas fa-arrow-right"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6">
                <div
                  class="property-item"
                  datastatus="Buy"
                  datatype="Apartments"
                  datalocation="Japan"
                  datasort="Best Seller"
                >
                  <div class="property-item__thumb">
                    <a
                      class="link"
                      href="https://cityscape.wowtheme7.com/property/your-journey-home-ownership-starts-here-too-"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/property-2-BItVODQO.png"
                        alt=""
                        class="cover-img"
                    /></a>
                  </div>
                  <div class="property-item__content">
                    <h6 class="property-item__price">
                      $450.00<span class="day">/per day</span>
                    </h6>
                    <h6 class="property-item__title">
                      <a
                        class="link"
                        href="https://cityscape.wowtheme7.com/property/your-journey-home-ownership-starts-here-too-"
                        >Your journey home ownership starts here too
                      </a>
                    </h6>
                    <p class="property-item__location d-flex gap-2">
                      <span class="icon">
                        <i class="fas fa-map-marker-alt"></i></span
                      >66 Broklyant, New York America
                    </p>
                    <div class="property-item__bottom flx-between gap-2">
                      <ul class="amenities-list flx-align">
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bed"></i></span
                          ><span class="text">4 Beds</span>
                        </li>
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bath"></i></span
                          ><span class="text"> 2 Baths </span>
                        </li>
                      </ul>
                      <a
                        class="simple-btn"
                        href="https://cityscape.wowtheme7.com/property/your-journey-home-ownership-starts-here-too-"
                        >Book Now<span class="icon-right">
                          <i class="fas fa-arrow-right"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6">
                <div
                  class="property-item"
                  datastatus="Rent"
                  datatype="Office"
                  datalocation="Korea"
                  datasort="Best Match"
                >
                  <div class="property-item__thumb">
                    <a
                      class="link"
                      href="https://cityscape.wowtheme7.com/property/opening-doors-to-your-dreams-for-living-"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/property-3-D009Kb31.png"
                        alt=""
                        class="cover-img"
                    /></a>
                  </div>
                  <div class="property-item__content">
                    <h6 class="property-item__price">
                      $500.00<span class="day">/per day</span>
                    </h6>
                    <h6 class="property-item__title">
                      <a
                        class="link"
                        href="https://cityscape.wowtheme7.com/property/opening-doors-to-your-dreams-for-living-"
                        >Opening Doors to Your Dreams For Living
                      </a>
                    </h6>
                    <p class="property-item__location d-flex gap-2">
                      <span class="icon">
                        <i class="fas fa-map-marker-alt"></i></span
                      >66 Broklyant, New York America
                    </p>
                    <div class="property-item__bottom flx-between gap-2">
                      <ul class="amenities-list flx-align">
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bed"></i></span
                          ><span class="text">4 Beds</span>
                        </li>
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bath"></i></span
                          ><span class="text"> 3 Baths </span>
                        </li>
                      </ul>
                      <a
                        class="simple-btn"
                        href="https://cityscape.wowtheme7.com/property/opening-doors-to-your-dreams-for-living-"
                        >Book Now<span class="icon-right">
                          <i class="fas fa-arrow-right"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6">
                <div
                  class="property-item"
                  datastatus="Sell"
                  datatype="Villa"
                  datalocation="Singapore"
                  datasort="Low Price"
                >
                  <div class="property-item__thumb">
                    <a
                      class="link"
                      href="https://cityscape.wowtheme7.com/property/home-is-where-your-story-begins-"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/property-4-CQ83J6IM.png"
                        alt=""
                        class="cover-img" /></a
                    ><span class="property-item__badge">Sales</span>
                  </div>
                  <div class="property-item__content">
                    <h6 class="property-item__price">
                      $600.00<span class="day">/per day</span>
                    </h6>
                    <h6 class="property-item__title">
                      <a
                        class="link"
                        href="https://cityscape.wowtheme7.com/property/home-is-where-your-story-begins-"
                        >Home is Where Your Story Begins
                      </a>
                    </h6>
                    <p class="property-item__location d-flex gap-2">
                      <span class="icon">
                        <i class="fas fa-map-marker-alt"></i></span
                      >66 Broklyant, New York America
                    </p>
                    <div class="property-item__bottom flx-between gap-2">
                      <ul class="amenities-list flx-align">
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bed"></i></span
                          ><span class="text">5 Beds</span>
                        </li>
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bath"></i></span
                          ><span class="text"> 4 Baths </span>
                        </li>
                      </ul>
                      <a
                        class="simple-btn"
                        href="https://cityscape.wowtheme7.com/property/home-is-where-your-story-begins-"
                        >Book Now<span class="icon-right">
                          <i class="fas fa-arrow-right"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6">
                <div
                  class="property-item"
                  datastatus="Buy"
                  datatype="Houses"
                  datalocation="Germany"
                  datasort="High Price"
                >
                  <div class="property-item__thumb">
                    <a
                      class="link"
                      href="https://cityscape.wowtheme7.com/property/building-trust%2C-one-home-at-a-time"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/property-1-D5t-zcgy.png"
                        alt=""
                        class="cover-img" /></a
                    ><span class="property-item__badge">Sales</span>
                  </div>
                  <div class="property-item__content">
                    <h6 class="property-item__price">
                      $650.00<span class="day">/per day</span>
                    </h6>
                    <h6 class="property-item__title">
                      <a
                        class="link"
                        href="https://cityscape.wowtheme7.com/property/building-trust%2C-one-home-at-a-time"
                        >Building Trust, One Home at a Time</a
                      >
                    </h6>
                    <p class="property-item__location d-flex gap-2">
                      <span class="icon">
                        <i class="fas fa-map-marker-alt"></i></span
                      >66 Broklyant, New York America
                    </p>
                    <div class="property-item__bottom flx-between gap-2">
                      <ul class="amenities-list flx-align">
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bed"></i></span
                          ><span class="text">6 Beds</span>
                        </li>
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bath"></i></span
                          ><span class="text"> 4 Baths </span>
                        </li>
                      </ul>
                      <a
                        class="simple-btn"
                        href="https://cityscape.wowtheme7.com/property/building-trust%2C-one-home-at-a-time"
                        >Book Now<span class="icon-right">
                          <i class="fas fa-arrow-right"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6">
                <div
                  class="property-item"
                  datastatus="Rent"
                  datatype="Apartments"
                  datalocation="Thailand"
                  datasort="Medium Price"
                >
                  <div class="property-item__thumb">
                    <a
                      class="link"
                      href="https://cityscape.wowtheme7.com/property/brick-by-brick-your-dream-home-awaits-"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/property-6-BHbR1GQ5.png"
                        alt=""
                        class="cover-img" /></a
                    ><span class="property-item__badge">Sales</span>
                  </div>
                  <div class="property-item__content">
                    <h6 class="property-item__price">
                      $700.00<span class="day">/per day</span>
                    </h6>
                    <h6 class="property-item__title">
                      <a
                        class="link"
                        href="https://cityscape.wowtheme7.com/property/brick-by-brick-your-dream-home-awaits-"
                        >Brick by Brick Your Dream Home Awaits
                      </a>
                    </h6>
                    <p class="property-item__location d-flex gap-2">
                      <span class="icon">
                        <i class="fas fa-map-marker-alt"></i></span
                      >66 Broklyant, New York America
                    </p>
                    <div class="property-item__bottom flx-between gap-2">
                      <ul class="amenities-list flx-align">
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bed"></i></span
                          ><span class="text">7 Beds</span>
                        </li>
                        <li class="amenities-list__item flx-align">
                          <span class="icon"><i class="fas fa-bath"></i></span
                          ><span class="text"> 3 Baths </span>
                        </li>
                      </ul>
                      <a
                        class="simple-btn"
                        href="https://cityscape.wowtheme7.com/property/brick-by-brick-your-dream-home-awaits-"
                        >Book Now<span class="icon-right">
                          <i class="fas fa-arrow-right"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="text-center property__btn">
              <a
                class="btn btn-main"
                href="https://cityscape.wowtheme7.com/property"
                >Sell All Listing
                <span class="icon icon-right">
                  <i class="fas fa-arrow-right"></i> </span
              ></a>
            </div>
          </div>
        </section>
        <section class="property-type padding-y-120">
          <div class="container container-two">
            <div class="section-heading">
              <div class="section-heading__inner">
                <span class="section-heading__subtitle bg-gray-100"
                  ><span class="text-gradient fw-semibold">
                    Property Type
                  </span></span
                >
                <h2 class="section-heading__title">
                  Let us find the perfect the property for you
                </h2>
              </div>
            </div>
            <div class="row gy-4">
              <div class="col-lg-4 col-sm-6 col-xs-6">
                <div class="property-type-item">
                  <span class="property-type-item__icon"
                    ><img
                      src="data:image/svg+xml,%3csvg%20width=&#39;45&#39;%20height=&#39;45&#39;%20viewBox=&#39;0%200%2045%2045&#39;%20fill=&#39;none&#39;%20xmlns=&#39;http://www.w3.org/2000/svg&#39;%3e%3cpath%20d=&#39;M32.8825%2019.0836C32.7986%2019.0836%2032.7149%2019.0592%2032.6425%2019.0109L29.181%2016.7032C29.0606%2016.6229%2028.9883%2016.4879%2028.9883%2016.3432V12.1124C28.9883%2011.8734%2029.182%2011.6797%2029.421%2011.6797H32.8825C33.1215%2011.6797%2033.3152%2011.8734%2033.3152%2012.1124V18.6509C33.3152%2018.8105%2033.2274%2018.9571%2033.0867%2019.0323C33.0227%2019.0666%2032.9526%2019.0836%2032.8825%2019.0836ZM29.8537%2016.1116L32.4498%2017.8424V12.5451H29.8537V16.1116Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M36.3438%2021.199H8.65146C8.45848%2021.199%208.28878%2021.0711%208.23555%2020.8855C8.18233%2020.7%208.25849%2020.5017%208.42213%2020.3993L22.2683%2011.7454C22.4087%2011.6578%2022.5866%2011.6578%2022.727%2011.7454L36.5732%2020.3993C36.7368%2020.5017%2036.813%2020.7%2036.7598%2020.8855C36.7064%2021.0711%2036.5367%2021.199%2036.3438%2021.199ZM10.1602%2020.3336H34.8351L22.4976%2012.6227L10.1602%2020.3336Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M33.7452%2040.2398H11.2452C11.0063%2040.2398%2010.8125%2040.0461%2010.8125%2039.8071V20.7686C10.8125%2020.5297%2011.0063%2020.3359%2011.2452%2020.3359H33.7452C33.9842%2020.3359%2034.1779%2020.5297%2034.1779%2020.7686V39.8071C34.1779%2040.0461%2033.9842%2040.2398%2033.7452%2040.2398ZM11.6779%2039.3744H33.3125V21.2013H11.6779V39.3744Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M25.9573%2040.2383H19.0343C18.7953%2040.2383%2018.6016%2040.0446%2018.6016%2039.8056V29.421C18.6016%2029.182%2018.7953%2028.9883%2019.0343%2028.9883H25.9573C26.1964%2028.9883%2026.39%2029.182%2026.39%2029.421V39.8056C26.39%2040.0446%2026.1964%2040.2383%2025.9573%2040.2383ZM19.4669%2039.3729H25.5246V29.8537H19.4669V39.3729Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M36.3438%2040.2365H8.65144C8.41251%2040.2365%208.21875%2040.0428%208.21875%2039.8038C8.21875%2039.5648%208.41251%2039.3711%208.65144%2039.3711H36.3438C36.5828%2039.3711%2036.7764%2039.5648%2036.7764%2039.8038C36.7764%2040.0428%2036.5828%2040.2365%2036.3438%2040.2365Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M39.8059%2043.7007H5.1905C4.95157%2043.7007%204.75781%2043.507%204.75781%2043.268V1.72957C4.75781%201.49063%204.95157%201.29688%205.1905%201.29688H32.8828C33.1218%201.29688%2033.3155%201.49063%2033.3155%201.72957V8.21995H39.8059C40.0449%208.21995%2040.2386%208.41371%2040.2386%208.65264V43.268C40.2386%2043.507%2040.0449%2043.7007%2039.8059%2043.7007ZM5.6232%2042.8353H39.3732V9.08534H32.8828C32.6438%209.08534%2032.4501%208.89158%2032.4501%208.65264V2.16226H5.6232V42.8353Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M39.805%209.08534H32.8819C32.6429%209.08534%2032.4492%208.89158%2032.4492%208.65265V1.72957C32.4492%201.55459%2032.5546%201.39675%2032.7164%201.32977C32.8778%201.26296%2033.0642%201.29974%2033.1878%201.42358L40.1109%208.34665C40.2347%208.4704%2040.2717%208.65655%2040.2047%208.8182C40.1378%208.97994%2039.98%209.08534%2039.805%209.08534ZM33.3146%208.21996H38.7604L33.3146%202.77418V8.21996Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M29.4207%205.6232H8.65144C8.41251%205.6232%208.21875%205.42944%208.21875%205.1905C8.21875%204.95157%208.41251%204.75781%208.65144%204.75781H29.4207C29.6597%204.75781%2029.8534%204.95157%2029.8534%205.1905C29.8534%205.42944%2029.6597%205.6232%2029.4207%205.6232Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M29.4207%209.08413H8.65144C8.41251%209.08413%208.21875%208.89037%208.21875%208.65144C8.21875%208.41251%208.41251%208.21875%208.65144%208.21875H29.4207C29.6597%208.21875%2029.8534%208.41251%2029.8534%208.65144C29.8534%208.89037%2029.6597%209.08413%2029.4207%209.08413Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M17.3053%2012.5451H8.65144C8.41251%2012.5451%208.21875%2012.3513%208.21875%2012.1124C8.21875%2011.8734%208.41251%2011.6797%208.65144%2011.6797H17.3053C17.5442%2011.6797%2017.738%2011.8734%2017.738%2012.1124C17.738%2012.3513%2017.5442%2012.5451%2017.3053%2012.5451Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M12.113%2016.006H8.65144C8.41251%2016.006%208.21875%2015.8122%208.21875%2015.5733C8.21875%2015.3344%208.41251%2015.1406%208.65144%2015.1406H12.113C12.3519%2015.1406%2012.5457%2015.3344%2012.5457%2015.5733C12.5457%2015.8122%2012.3519%2016.006%2012.113%2016.006Z&#39;%20fill=&#39;white&#39;/%3e%3c/svg%3e"
                      alt=""
                  /></span>
                  <h6 class="property-type-item__title">
                    Seamless Solutions Your Success
                  </h6>
                  <p class="property-type-item__desc font-18">
                    Customer satisfaction is crucial for amohlodi business as it
                    leads to customer loyalty loves positive word
                  </p>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6 col-xs-6">
                <div class="property-type-item">
                  <span class="property-type-item__icon"
                    ><img
                      src="${pageContext.request.contextPath}/view/guest/asset/img/property-type-icon2-BwZ63RRz.svg"
                      alt=""
                  /></span>
                  <h6 class="property-type-item__title">
                    Proactive Realty Services
                  </h6>
                  <p class="property-type-item__desc font-18">
                    Customer satisfaction is crucial for amohlodi business as it
                    leads to customer loyalty loves positive word
                  </p>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6 col-xs-6">
                <div class="property-type-item">
                  <span class="property-type-item__icon"
                    ><img
                      src="${pageContext.request.contextPath}/view/guest/asset/img/property-type-icon3-BLEs1TEV.svg"
                      alt=""
                  /></span>
                  <h6 class="property-type-item__title">
                    Supreme Home Finders
                  </h6>
                  <p class="property-type-item__desc font-18">
                    Customer satisfaction is crucial for amohlodi business as it
                    leads to customer loyalty loves positive word
                  </p>
                </div>
              </div>
            </div>
          </div>
        </section>
        <div class="video-popup">
          <div class="container container-two">
            <div class="video-popup__thumb">
              <img
                src="${pageContext.request.contextPath}/view/guest/asset/img/video-popup.png"
                alt=""
                class="cover-img"
              /><a
                class="popup-video-link video-popup__button"
                href="https://www.youtube.com/watch?v=pPl3ZZdTP3g"
                ><i class="fas fa-play"></i
              ></a>
            </div>
          </div>
        </div>
        <section class="counter padding-y-120">
          <div class="container">
            <div class="row gy-4">
              <div class="col-sm-3 col-6">
                <div class="counter-item position-relative">
                  <h2 class="counter-item__number counter"><span>200</span></h2>
                  <span class="counter-item__text"> HAPPY PATIENTS</span>
                </div>
              </div>
              <div class="col-sm-3 col-6">
                <div class="counter-item position-relative">
                  <h2 class="counter-item__number counter"><span>20</span></h2>
                  <span class="counter-item__text"> SAVED HEARTS </span>
                </div>
              </div>
              <div class="col-sm-3 col-6">
                <div class="counter-item position-relative">
                  <h2 class="counter-item__number counter"><span>10</span></h2>
                  <span class="counter-item__text"> EXPERT DOCTORS</span>
                </div>
              </div>
              <div class="col-sm-3 col-6">
                <div class="counter-item position-relative">
                  <h2 class="counter-item__number counter"><span>900</span></h2>
                  <span class="counter-item__text"> SERENITY WORK </span>
                </div>
              </div>
            </div>
          </div>
        </section>
        <div class="Toastify"></div>
        <section class="message">
          <div class="container container-two">
            <div class="row">
              <div class="col-lg-5">
                <div class="message-thumb">
                  <img
                    src="${pageContext.request.contextPath}/view/guest/asset/img/message-img-C3fho8PI.png"
                    alt=""
                    class="cover-img"
                  />
                </div>
              </div>
              <div class="col-lg-7">
                <div class="form-box">
                  <h2 class="form-box__title">Get A Quote</h2>
                  <form action="https://cityscape.wowtheme7.com/#">
                    <div class="row gy-30">
                      <div class="col-sm-6 col-xs-6">
                        <div class="position-relative">
                          <input
                            type="text"
                            placeholder="Name"
                            name="name"
                            id="name"
                            class="common-input common-input--withIcon"
                            value=""
                          /><span class="input-icon"
                            ><i class="fas fa-user"></i
                          ></span>
                        </div>
                      </div>
                      <div class="col-sm-6 col-xs-6">
                        <div class="position-relative">
                          <input
                            type="tel"
                            placeholder="Your Phone"
                            name="phone"
                            id="phone"
                            class="common-input common-input--withIcon"
                            value=""
                          /><span class="input-icon"
                            ><i class="fas fa-phone"></i
                          ></span>
                        </div>
                      </div>
                      <div class="col-sm-6 col-xs-6">
                        <div class="position-relative">
                          <input
                            type="email"
                            placeholder="Your Email"
                            name="email"
                            id="email"
                            class="common-input common-input--withIcon"
                            value=""
                          /><span class="input-icon"
                            ><i class="fas fa-paper-plane"></i
                          ></span>
                        </div>
                      </div>
                      <div class="col-sm-6 col-xs-6">
                        <div class="position-relative">
                          <input
                            type="text"
                            placeholder="Your Address"
                            name="address"
                            id="address"
                            class="common-input common-input--withIcon"
                            value=""
                          /><span class="input-icon"
                            ><i class="fas fa-map-marker-alt"></i
                          ></span>
                        </div>
                      </div>
                      <div class="col-lg-12">
                        <div class="position-relative">
                          <textarea
                            placeholder="Write Message.."
                            name="message"
                            id="message"
                            class="common-input common-input--withIcon"
                          ></textarea
                          ><span class="input-icon"
                            ><i class="fas fa-envelope"></i
                          ></span>
                        </div>
                      </div>
                      <div class="col-lg-12">
                        <button type="submit" class="btn btn-main w-100">
                          Send Message
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="portfolio padding-t-120 padding-b-60 overflow-hidden">
          <div class="section-heading">
            <span class="section-heading__subtitle">
              <span class="text-gradient fw-semibold">Latest Portfolio</span>
            </span>
            <h2 class="section-heading__title">
              Optimum Homes &amp; Properties Realty Experts
            </h2>
          </div>
          <div class="portfolio-wrapper">
            <div class="slick-slider slick-initialized" dir="ltr">
              <div class="slick-list" style="padding: 0px 50px">
                <div
                  class="slick-track"
                  style="
                    width: 7188px;
                    opacity: 1;
                    transform: translate3d(-2995px, 0px, 0px);
                    transition: -webkit-transform 1500ms;
                  "
                >
                  <div
                    data-index="-4"
                    tabindex="-1"
                    class="slick-slide slick-cloned"
                    aria-hidden="true"
                    style="width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio1-BxOjKKrh.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="-3"
                    tabindex="-1"
                    class="slick-slide slick-cloned"
                    aria-hidden="true"
                    style="width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio2-JvFDWxue.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="-2"
                    tabindex="-1"
                    class="slick-slide slick-center slick-cloned"
                    aria-hidden="true"
                    style="width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio3-zU6U6SCf.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="-1"
                    tabindex="-1"
                    class="slick-slide slick-cloned"
                    aria-hidden="true"
                    style="width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio4-DoIkziu9.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="0"
                    class="slick-slide"
                    tabindex="-1"
                    aria-hidden="true"
                    style="outline: none; width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio1-BxOjKKrh.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="1"
                    class="slick-slide slick-active"
                    tabindex="-1"
                    aria-hidden="false"
                    style="outline: none; width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio2-JvFDWxue.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="2"
                    class="slick-slide slick-active slick-center slick-current"
                    tabindex="-1"
                    aria-hidden="false"
                    style="outline: none; width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio3-zU6U6SCf.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="3"
                    class="slick-slide slick-active"
                    tabindex="-1"
                    aria-hidden="false"
                    style="outline: none; width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio4-DoIkziu9.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="4"
                    tabindex="-1"
                    class="slick-slide slick-cloned"
                    aria-hidden="true"
                    style="width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio1-BxOjKKrh.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="5"
                    tabindex="-1"
                    class="slick-slide slick-cloned"
                    aria-hidden="true"
                    style="width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio2-JvFDWxue.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="6"
                    tabindex="-1"
                    class="slick-slide slick-center slick-cloned"
                    aria-hidden="true"
                    style="width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio3-zU6U6SCf.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    data-index="7"
                    tabindex="-1"
                    class="slick-slide slick-cloned"
                    aria-hidden="true"
                    style="width: 599px"
                  >
                    <div>
                      <div class="portfolio-item">
                        <div class="portfolio-item__thumb">
                          <img
                            src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio4-DoIkziu9.png"
                            alt=""
                            class="cover-img"
                          />
                        </div>
                        <div class="portfolio-item__content">
                          <a
                            class="btn btn-icon"
                            href="https://cityscape.wowtheme7.com/project"
                            ><span class="text-gradient line-height-0"
                              ><i class="fas fa-arrow-right"></i></span
                          ></a>
                          <div class="portfolio-item__inner">
                            <h6 class="portfolio-item__title">
                              <a
                                class="link"
                                href="https://cityscape.wowtheme7.com/project"
                                >Outsourcing business</a
                              >
                            </h6>
                            <p class="portfolio-item__desc">
                              Real Estate is a vast industry that deals with the
                              buying, selling, and renting of properties
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <button class="d-none">Prev</button
            ><button class="d-none">Next</button>
          </div>
        </section>
        <section class="testimonial padding-y-60">
          <div class="container container-two">
            <div class="section-heading section-heading style-left style-flex">
              <div class="section-heading__inner">
                <span class="section-heading__subtitle"
                  ><span class="text-gradient fw-semibold">
                    Client Testimonial
                  </span></span
                >
                <h2 class="section-heading__title">
                  Optimum Homes &amp; Properties property for you
                </h2>
              </div>
              <p class="section-heading__desc">
                Use receiving accounts a number a currencies and get paid like a
                local Use receivin accounts a number paid the most beautiful
                think
              </p>
            </div>
            <div class="testimonial__inner">
              <div class="row">
                <div class="col-lg-6 col-md-8">
                  <div
                    class="testimonial-box overflow-hidden position-relative"
                  >
                    <div class="slick-slider slick-initialized" dir="ltr">
                      <button
                        type="button"
                        data-role="none"
                        class="slick-arrow slick-prev"
                        style="display: block"
                      >
                        Previous
                      </button>
                      <div class="slick-list">
                        <div
                          class="slick-track"
                          style="width: 2555px; opacity: 1"
                        >
                          <div
                            data-index="0"
                            class="slick-slide slick-active slick-current"
                            tabindex="-1"
                            aria-hidden="false"
                            style="
                              outline: none;
                              width: 511px;
                              position: relative;
                              left: 0px;
                              opacity: 1;
                              z-index: 999;
                              transition: opacity 900ms, visibility 900ms;
                            "
                          >
                            <div>
                              <div class="testimonial-item">
                                <div class="testimonial-item__top flx-between">
                                  <div class="testimonial-item__info">
                                    <h6 class="testimonial-item__name">
                                      Sakib Fahad
                                    </h6>
                                    <span class="testimonial-item__designation"
                                      >Content Creator</span
                                    >
                                  </div>
                                  <img
                                    src="data:image/svg+xml,%3csvg%20width=&#39;60&#39;%20height=&#39;60&#39;%20viewBox=&#39;0%200%2060%2060&#39;%20fill=&#39;none&#39;%20xmlns=&#39;http://www.w3.org/2000/svg&#39;%3e%3cpath%20d=&#39;M59.7656%2019.582C59.7656%2013.0078%2054.4336%207.67578%2047.8594%207.67578C41.2852%207.67578%2035.9531%2013.0078%2035.9531%2019.582C35.9531%2026.1562%2041.2852%2031.4883%2047.8594%2031.4883C49.8281%2031.4883%2051.6445%2030.9727%2053.2852%2030.1289C51.1758%2039.4102%2042.8672%2046.3711%2032.9531%2046.3711C31.3125%2046.3711%2029.9766%2047.707%2029.9766%2049.3477C29.9766%2050.9883%2031.3125%2052.3242%2032.9531%2052.3242C47.7422%2052.3242%2059.7656%2040.3008%2059.7656%2025.5117V19.582ZM30.0234%2019.582C30.0234%2013.0078%2024.6914%207.67578%2018.1172%207.67578C11.543%207.67578%206.21094%2013.0078%206.21094%2019.582C6.21094%2026.1562%2011.543%2031.4883%2018.1172%2031.4883C20.0859%2031.4883%2021.9023%2030.9727%2023.543%2030.1289C21.4336%2039.4102%2013.125%2046.3711%203.21094%2046.3711C1.57031%2046.3711%200.234375%2047.707%200.234375%2049.3477C0.234375%2050.9883%201.57031%2052.3242%203.21094%2052.3242C18%2052.3242%2030.0234%2040.3008%2030.0234%2025.5117V19.582Z&#39;%20fill=&#39;url(%23paint0_linear_3906_1348)&#39;/%3e%3cdefs%3e%3clinearGradient%20id=&#39;paint0_linear_3906_1348&#39;%20x1=&#39;0.259072&#39;%20y1=&#39;30.0008&#39;%20x2=&#39;59.7899&#39;%20y2=&#39;30.0008&#39;%20gradientUnits=&#39;userSpaceOnUse&#39;%3e%3cstop%20stop-color=&#39;%23F69220&#39;/%3e%3cstop%20offset=&#39;0.2863&#39;%20stop-color=&#39;%23F68E20&#39;/%3e%3cstop%20offset=&#39;0.5401&#39;%20stop-color=&#39;%23F48421&#39;/%3e%3cstop%20offset=&#39;0.7807&#39;%20stop-color=&#39;%23F37221&#39;/%3e%3cstop%20offset=&#39;1&#39;%20stop-color=&#39;%23F05A22&#39;/%3e%3c/linearGradient%3e%3c/defs%3e%3c/svg%3e"
                                    alt=""
                                  />
                                </div>
                                <p class="testimonial-item__desc">
                                  Their product exceeded his my routi
                                  expectations. The the quality and attention to
                                  detail a the a moutstanding and it has become
                                  an essential most a education the a man who
                                  can do tant clearly
                                </p>
                                <ul
                                  class="star-rating flx-align justify-content-end"
                                >
                                  <li class="star-rating__item">
                                    <i class="fas fa-star"></i>
                                  </li>
                                  <li class="star-rating__item">
                                    <i class="fas fa-star"></i>
                                  </li>
                                  <li class="star-rating__item">
                                    <i class="fas fa-star"></i>
                                  </li>
                                  <li class="star-rating__item">
                                    <i class="fas fa-star"></i>
                                  </li>
                                  <li class="star-rating__item unabled">
                                    <i class="fas fa-star"></i>
                                  </li>
                                </ul>
                              </div>
                            </div>
                          </div>
                          <div
                            data-index="1"
                            class="slick-slide"
                            tabindex="-1"
                            aria-hidden="true"
                            style="
                              outline: none;
                              width: 511px;
                              position: relative;
                              left: -511px;
                              opacity: 0;
                              z-index: 998;
                              transition: opacity 900ms, visibility 900ms;
                            "
                          >
                            <div>
                              <div class="testimonial-item">
                                <div class="testimonial-item__top flx-between">
                                  <div class="testimonial-item__info">
                                    <h6 class="testimonial-item__name">
                                      John Doe
                                    </h6>
                                    <span class="testimonial-item__designation"
                                      >Frontend Developer</span
                                    >
                                  </div>
                                  <img
                                    src="data:image/svg+xml,%3csvg%20width=&#39;60&#39;%20height=&#39;60&#39;%20viewBox=&#39;0%200%2060%2060&#39;%20fill=&#39;none&#39;%20xmlns=&#39;http://www.w3.org/2000/svg&#39;%3e%3cpath%20d=&#39;M59.7656%2019.582C59.7656%2013.0078%2054.4336%207.67578%2047.8594%207.67578C41.2852%207.67578%2035.9531%2013.0078%2035.9531%2019.582C35.9531%2026.1562%2041.2852%2031.4883%2047.8594%2031.4883C49.8281%2031.4883%2051.6445%2030.9727%2053.2852%2030.1289C51.1758%2039.4102%2042.8672%2046.3711%2032.9531%2046.3711C31.3125%2046.3711%2029.9766%2047.707%2029.9766%2049.3477C29.9766%2050.9883%2031.3125%2052.3242%2032.9531%2052.3242C47.7422%2052.3242%2059.7656%2040.3008%2059.7656%2025.5117V19.582ZM30.0234%2019.582C30.0234%2013.0078%2024.6914%207.67578%2018.1172%207.67578C11.543%207.67578%206.21094%2013.0078%206.21094%2019.582C6.21094%2026.1562%2011.543%2031.4883%2018.1172%2031.4883C20.0859%2031.4883%2021.9023%2030.9727%2023.543%2030.1289C21.4336%2039.4102%2013.125%2046.3711%203.21094%2046.3711C1.57031%2046.3711%200.234375%2047.707%200.234375%2049.3477C0.234375%2050.9883%201.57031%2052.3242%203.21094%2052.3242C18%2052.3242%2030.0234%2040.3008%2030.0234%2025.5117V19.582Z&#39;%20fill=&#39;url(%23paint0_linear_3906_1348)&#39;/%3e%3cdefs%3e%3clinearGradient%20id=&#39;paint0_linear_3906_1348&#39;%20x1=&#39;0.259072&#39;%20y1=&#39;30.0008&#39;%20x2=&#39;59.7899&#39;%20y2=&#39;30.0008&#39;%20gradientUnits=&#39;userSpaceOnUse&#39;%3e%3cstop%20stop-color=&#39;%23F69220&#39;/%3e%3cstop%20offset=&#39;0.2863&#39;%20stop-color=&#39;%23F68E20&#39;/%3e%3cstop%20offset=&#39;0.5401&#39;%20stop-color=&#39;%23F48421&#39;/%3e%3cstop%20offset=&#39;0.7807&#39;%20stop-color=&#39;%23F37221&#39;/%3e%3cstop%20offset=&#39;1&#39;%20stop-color=&#39;%23F05A22&#39;/%3e%3c/linearGradient%3e%3c/defs%3e%3c/svg%3e"
                                    alt=""
                                  />
                                </div>
                                <p class="testimonial-item__desc">
                                  Lorem ipsum dolor sit amet consectetur
                                  adipisicing elit. Optio, autem! Consectetur
                                  illo tempora sed repudiandae eaque velit
                                  expedita, ipsa earum explicabo libero,
                                  voluptatibus aliquid odio
                                </p>
                                <ul
                                  class="star-rating flx-align justify-content-end"
                                >
                                  <li class="star-rating__item">
                                    <i class="fas fa-star"></i>
                                  </li>
                                  <li class="star-rating__item">
                                    <i class="fas fa-star"></i>
                                  </li>
                                  <li class="star-rating__item unabled">
                                    <i class="fas fa-star"></i>
                                  </li>
                                  <li class="star-rating__item unabled">
                                    <i class="fas fa-star"></i>
                                  </li>
                                  <li class="star-rating__item unabled">
                                    <i class="fas fa-star"></i>
                                  </li>
                                </ul>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <button
                        type="button"
                        data-role="none"
                        class="slick-arrow slick-next"
                        style="display: block"
                      >
                        Next
                      </button>
                    </div>
                    <button class="slick-arrow slick-prev">
                      <i class="fas fa-arrow-left"></i></button
                    ><button class="slick-arrow slick-next">
                      <i class="fas fa-arrow-right"></i>
                    </button>
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="testimonial-thumb">
                    <img
                      src="${pageContext.request.contextPath}/view/guest/asset/img/blog3-DF6jBTUN.png"
                      alt=""
                      class="cover-img"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="blog padding-t-60 padding-b-120">
          <div class="container container-two">
            <div
              class="section-heading section-heading style-left style-flex flx-between align-items-end gap-3"
            >
              <div class="section-heading__inner">
                <span class="section-heading__subtitle"
                  ><span class="text-gradient fw-semibold">
                    Latest Product
                  </span></span
                >
                <h2 class="section-heading__title">
                  Prestige Property Management property for you
                </h2>
              </div>
              <a
                class="btn btn-outline-main"
                href="https://cityscape.wowtheme7.com/blog"
                >View Moreee<span class="icon icon-right">
                  <i class="fas fa-arrow-right"></i> </span
              ></a>
            </div>
            <div class="row gy-4">
              <div class="col-lg-4 col-sm-6">
                <div class="blog-item">
                  <div class="blog-item__thumb">
                    <a
                      class="blog-item__thumb-link"
                      href="https://cityscape.wowtheme7.com/blog/discover-endless-possibilities-in-real-estate-live-your-best-life"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/blog1-Bb05HVyH.png"
                        class="cover-img"
                        alt="Blog Image"
                    /></a>
                  </div>
                  <div class="blog-item__inner">
                    <div class="blog-item__date">
                      19<span class="text">May</span>
                    </div>
                    <div class="blog-item__content">
                      <ul class="text-list flx-align">
                        <li class="text-list__item font-12">
                          <span class="icon"><i class="fas fa-user"></i></span
                          ><a
                            class="link"
                            href="https://cityscape.wowtheme7.com/"
                          >
                            By admin</a
                          >
                        </li>
                        <li class="text-list__item font-12">
                          <span class="icon"
                            ><i class="fas fa-comments"></i></span
                          ><a
                            class="link"
                            href="https://cityscape.wowtheme7.com/"
                            >Comments (30)</a
                          >
                        </li>
                      </ul>
                      <h6 class="blog-item__title">
                        <a
                          class="blog-item__title-link border-effect"
                          href="https://cityscape.wowtheme7.com/blog/discover-endless-possibilities-in-real-estate-live-your-best-life"
                        >
                          Discover Endless Possibilities in Real Estate Live
                          Your Best Life</a
                        >
                      </h6>
                      <a
                        class="simple-btn text-heading fw-semibold"
                        href="https://cityscape.wowtheme7.com/blog/discover-endless-possibilities-in-real-estate-live-your-best-life"
                        >Read More<span class="icon-right text-gradient">
                          <i class="fas fa-plus"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6">
                <div class="blog-item">
                  <div class="blog-item__thumb">
                    <a
                      class="blog-item__thumb-link"
                      href="https://cityscape.wowtheme7.com/blog/turn-your-real-estate-dreams-into-reality-embrace-the-real-estate"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/blog2-BFpQjJT0.png"
                        class="cover-img"
                        alt="Blog Image"
                    /></a>
                  </div>
                  <div class="blog-item__inner">
                    <div class="blog-item__date">
                      19<span class="text">May</span>
                    </div>
                    <div class="blog-item__content">
                      <ul class="text-list flx-align">
                        <li class="text-list__item font-12">
                          <span class="icon"><i class="fas fa-user"></i></span
                          ><a
                            class="link"
                            href="https://cityscape.wowtheme7.com/"
                          >
                            By admin</a
                          >
                        </li>
                        <li class="text-list__item font-12">
                          <span class="icon"
                            ><i class="fas fa-comments"></i></span
                          ><a
                            class="link"
                            href="https://cityscape.wowtheme7.com/"
                            >Comments (50)</a
                          >
                        </li>
                      </ul>
                      <h6 class="blog-item__title">
                        <a
                          class="blog-item__title-link border-effect"
                          href="https://cityscape.wowtheme7.com/blog/turn-your-real-estate-dreams-into-reality-embrace-the-real-estate"
                        >
                          Turn Your Real Estate Dreams Into Reality Embrace the
                          Real Estate</a
                        >
                      </h6>
                      <a
                        class="simple-btn text-heading fw-semibold"
                        href="https://cityscape.wowtheme7.com/blog/turn-your-real-estate-dreams-into-reality-embrace-the-real-estate"
                        >Read More<span class="icon-right text-gradient">
                          <i class="fas fa-plus"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-sm-6">
                <div class="blog-item">
                  <div class="blog-item__thumb">
                    <a
                      class="blog-item__thumb-link"
                      href="https://cityscape.wowtheme7.com/blog/your-journey-to-home-ownership-starts-here%3A-the-satisfaction"
                      ><img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/blog3-DF6jBTUN.png"
                        class="cover-img"
                        alt="Blog Image"
                    /></a>
                  </div>
                  <div class="blog-item__inner">
                    <div class="blog-item__date">
                      19<span class="text">May</span>
                    </div>
                    <div class="blog-item__content">
                      <ul class="text-list flx-align">
                        <li class="text-list__item font-12">
                          <span class="icon"><i class="fas fa-user"></i></span
                          ><a
                            class="link"
                            href="https://cityscape.wowtheme7.com/"
                          >
                            By admin</a
                          >
                        </li>
                        <li class="text-list__item font-12">
                          <span class="icon"
                            ><i class="fas fa-comments"></i></span
                          ><a
                            class="link"
                            href="https://cityscape.wowtheme7.com/"
                            >Comments (10)</a
                          >
                        </li>
                      </ul>
                      <h6 class="blog-item__title">
                        <a
                          class="blog-item__title-link border-effect"
                          href="https://cityscape.wowtheme7.com/blog/your-journey-to-home-ownership-starts-here%3A-the-satisfaction"
                        >
                          Your Journey to Home Ownership Starts Here: The
                          Satisfaction</a
                        >
                      </h6>
                      <a
                        class="simple-btn text-heading fw-semibold"
                        href="https://cityscape.wowtheme7.com/blog/your-journey-to-home-ownership-starts-here%3A-the-satisfaction"
                        >Read More<span class="icon-right text-gradient">
                          <i class="fas fa-plus"></i> </span
                      ></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <footer class="footer footer-two padding-y-120">
          <div class="container container-two">
            <div class="row gy-5">
              <div class="col-xl-4 col-lg-6">
                <div class="footer-item">
                  <div class="footer-item__logo">
                    <a
                      class="mobile-menu__logo"
                      href="https://cityscape.wowtheme7.com/"
                      ><img
                        src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMAAAAAoCAYAAACoy/XoAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAA8tSURBVHgB7V1fbxvHEZ890kZlyzaFvrVAvQz61JfQQN9DfQLLbwVaxLSBNAWawlIMN0iTVqTRNE2cVBTSPqWA6KDPsdwvwHO/gOT3wjzlqWiLUnIkM7Wk287szpLL0/HuSNmSat8PXt/d/pnbPc7MzszunQSMQHdJlr6l4DIoqCoBVTxKzFZqHwSe4wmAwAKdF2JeiGf9hKWhEFh3kIfn+pqPYo9p7SONAixfWHk0DzlyHDGKcZk7S3IRD/PI36V+phDE2AIPxPtArK8U1lBCDDUWWjQE11FALUxNrmdPdJGCb+PltnoVcuQ4BgwJQG9JylCoe8iWFcPhoBmaWBbZ2qh7MDMAnYrBqSmlFGoR0UJAvK5CxbU042MBTRv0TwjvO3oaUXs7BQE5chwD+gJAzI+s2UY2lX3mJyjxN2TltX2lHhoGJx4HbcoYcSiwoFAZ2TbKmDyYqRSWecZc0vCwfK+gGxe+C5fFObgcbmE2SUmOHMeAvgCg5m+jUpYwYMUAefra1NuBD88BO8tSwi7MkeSEffMoR46jhUf/9ZblomZ+DUUGzN0pgEtTC8nM363J0taCvAE5cvyfotg1pk9dKLCG+8aZhaCW1rA7L0velmgXzkEFtXnp7I2gARPCE5CbQDmOBd4p0CFONPWVseUVzGZq+BSWUFpeNQEeqNMsAuMgZDeD5psQcuQ4FnieB3MDfxfuo9kTpDV6fPOVFTSZajoiJARHh9TiOEKA9zWrCDp65J1YHwDls4KpCjleSHjIet+zkXwRgp/W4PGv5IonVA0Ex/lpBtAmjKayyGsIqQihvy6AQnQyo0A4tBoe1jC18TxfqHsBUdxX8FfUxvdD5MEzp7x7SZV3GnIxfKo1v2Z+zcTfgmU0YrQjzKsBdRQCOLuQ7BN4pr1GGD6fKBBr7gomWmiTnL2J6SGmVZy81lNIVJ1zjFhBM0KfaNNi4WYGWocGj+c1MGOyi5Q0Fh/vvwo5xkYRZ4A27O5hCL8otvdUuXdbyr0ehut7tEILMPNnEwna+UAuqj1Rh/4SL6rugro2/V7Q6n0mu8jNdZOp17rquK4AUwlCEAJxvafJecKDZwlmzCUYZmAXxMyLWC/A45UE5m1huuqcR2Hv8QBG3+vQwH4Ss6+A6XcUVUw3eCyzOJYAcmRGEdnVB68IBe0IC9gzjjAW4MGY5qJ3Ry7u7yLzA5g1YV0Xrp//PGhR3tQvggba/1hfLdqtEVilvn1Hbk3fCpqxdw49Ye2eUD07L5hNlSUnawOTjyngawlGi0pOa9imjoxzQFgxz8eyGT7fhOMDzcxVPidhW+ckwQio5ESmWi4EY8DT2xP+C/2VX2G3NJzDwymlep+i2aNQu9sqQhv/189/ZpjfYgrDoCoUtwcryIrkZ6n3kbwaf2c+GicYngUizB+A0YiSHHZMdU50Xsaya2DMIUJ9lI1PjH+czM9+SJUvG9iXKqZ5TC0eD41lmcslmJkiR0bQDEBb0lT4b2TFc7BButg7Bxf1ukBRb2yoU0XBm9zAU9en7wwzvwXa/dr+x0aLdkMczhStpx+X1elfdr6I1jcb6sDxBiYHMoqEg8wfjKpPDIRtfDBOLpkYS3i9Tlo/QrPKl76lh/lz3Mba4ReZUS0Cnj1svc0sNjqbbhXbP862Zg/RqEP8WOax7VW+V5VMplFCy+YU0ZTUb0xbYJ7XataZw6FBfb0AZpZdd8fojD1wnymX1fh03ZqfI2j60bZj9ovGtg7Ob3cAT5pSPfm9DL9+u6y6P/l+VectSbXzSVnR8cmneP6xVNsfltX2bVmDDED7v/7kD9gO2z65U1Y7H5VV73fDMwEuntV3PkG6v5bh5k/LPhwSOPh7agA5Rrt5p107UlZ1ympOflslw+d6TSevmqEvHbd95F5rKW11uDbpPjzWbkK/V9KeHZYvJtDo2OeExyA6FoeGRT0jzbmUPpVSaNixlaJti4aAjcLsmYOnQ5tmV6dxA8hSujb9m2HN331DVko/gOCbU+LC1FudDZuPzi85wfSeAJkW1J72zrV6v0XH+P3g7lAP9DrC4Uwg/tHsQ2qNYwNjXWLScSMoFHmhJ0PRJa3hOc/COtVE124Vof75owgqw7iSL1tO0RYfpUrQ7GlRKGIAPNT4kmjc56OEQZSMykmIYmfPCA0CjZnuW3JoxDJaxn6RfxNE6FEi5Rbrp/G9SHFVImODCJ1a3Ng8juGz6c5743hxy2zlFxSlb0y/O2D+7odSbi/KdsETX+4V4FX1VAU7Hw7H/3UESJHNal0HevdFNLc/kKajodkgLbSvfeh1AFdDLMOYoAdiU8b6ZINXYcDoD9k2t2me6/kwYPqrKYxR42PgmD/g3IPajrfaziDt6NAnBVRmX4jGMcd+hGUuCcbpTqIRgDExK0xnzvGrqIxM0QuQjqtMc537VI2h5/pp1RgaTRgw/7IzttqIsQ35SF5fx7u5aui0ce6doO4Wnz6NEmcYQOztc1MMkW7NyyFH8uwt3c5lyBJKQXu7LiteAQIKJ5H0herQ6wBVPh5JPH5MuNqoFleBBcOaiH6kmH7ggM/n2SSYVxnNPK5X58sHzBgHZhH2L+xvVXHNjgiNAAzz+zE0WlQGhmmzzAISjMBfilM+TO+KkzWkAFgg7HNrsECnjW3ITPTMZhyzK2fQwuzgx/Bk4+zNYeZHJ3cOuVWSUxxV22JPHNBQZ24FC0j/br+ufstMtPf/gVK/ryUTo6eH3gxntU0AJw8tGGixyyPquDPY0DTPPygxVcBZEoyG7bAwrKhk/8KlPQ/JqIOZIe7CwBw70L+U4AKVjTMLzyYVsqBZsznq49T4SM+oBcmow+B36PujnrbvDfv1tTC/AdY4u/DVQZsLSHNrYo0CqOY3dC2ggSvJDRGKZtydp9/Ru0td2/8C2j1t9R9xT4dOX2AwA7vapxJTzf4g90dowoCnctKG9BztDynBMEGbhSGOthW61NmRQ77WfGiOoNGCdDQhGx5kNDtbzrk7Rvsq7cM0Ovw72PFXbX6RC4dUMJoktymkOYqY55mXv/b1Slmo/9HmtjBhW+f0u53aY3SCPSWusndRQuOnXezBpTAlwpEB1lHM7HwdMVZhMH2TNu0zohoOtbaSiHCYcZXbVZkWMaeEwaJe1Dyxz+QhTI6xaBCzYT8oKHIxpWoHssEVXOmcW2G4qCIRvBE4oCBMFKj/TqPB2RujmR8KaB/u4o9ZELR+tTFdgLVdjPvTxgZl5Kgxqun594Pa40YZp53wdaWMEOx74O9OZ9uCnYCAj4mRkuMCaV4OB1bBRIXqTrE9D8QY+3kcB5v8ATJt7BoIObAzTtUZODyeBY2JwQJlL+OcawnDgpEZ7hu7Y/XJOs99J5jz0xqeX+zUwlB8YT8ZgTeXBSHavZ+X07RFElzGqcHJhDWDShE79jU+NmBCsLnScOi7mq7LxyxRmVGwNMb5jQ5zvyFExrPhnFtF9wCML5E19R3rojFHsr+ShZU3sbqvL0K1gZbQJhpCvhaIMBuZ87fRHHqvTDKgbV9yqvcFkBDMTv2pswHjg6ZIG3kgmlltUGuCWPNkQ4xYbT0sSLvjvWwf6X4+R1okV/Ehvn8VbgMieVXUNRMqzvVDvj7M7DgWDbfPKaDxX8tQzxWA9ch5FXSwPvuK8RBoJXgHV3ndleCjQLcuS9vvlNe+voX3XsD01ivq8ZvlR92alDAB1PCKbuZ4uRpe1a1FyqqjyiJt/Qy3ovp1hx5p6lW7SpnQJuA63RTacw7t6oj8WgqNCjvTlOpOvvsc6pA+zpZT348pV1n7xPU77nNz8t3nKVNoSP69KM3bfLMQZsKehw1FZgYxufjKW9ndUlfwruvaGqJPoygKr4p290fjCwGbAT5f0oNJFAJmQGK8KmcFGSMcLqzzndU0cGcmstltdOVuQhtr3pVU8ks5dsXZjXYQfBj4SIspjEJ9kpxaNpO1a+DQuDqKAD/3keVx90zqE9Oz5a3I7EPP017fUyMWGjnf7qil1DeZ9UKYTf2tEM8bXqGKN5sTPXFvb0tdw3s/1D4xJnRKLopThZUJKZNtZ3/8OmuOGmu2EqcKP1SKPNW4bgAwkSMe8JG0yzzTlqN+CP7xfL6sWRop07f7IxOzDDExa2eKgFQ5a9llEj63Zga1a6v4mc6l0YgJK7qmCmn4FeXY5kyjBcapp7ZZTFkfjKm0xuOqMK2S06c61w0gfo3E5lWYTs2tw7Ohu1VieGxHbQJ1fybl1hvlztb1stp6vRx2f1xepS9MbL1VXnv85isK8zuTmkEEfnhNlR1JmiPNBCJmj9uA5Sf0rxqpW8swJmuapKGZQKMWU78T0/80Gt2UPnSUeS6BGvEsnLr1Ef2KpZnQr7qacGyeJaHNkCOYAQrKWxKk5WnTtNb6heZMM9gMi2oWe7AanlazM630F/NHgRdzyFQogzEtgphqdnGKYuZXJg2bsia5BCYKkYkGa/tNpx9+hjY0q9EMNWo8OgrC4x5FowWDZ2IhYeCsZqVxCeJNNquNY7c1ZOjXg0lpcuBiorEJmgFUDwM4/0L2/2dhduYvf/fhOYC0fHEXvlT7YlbRF6HNl6ObF1qPFuA5QxkNbx/Gcb/gImGwAEQ2bZYoSJQGjYWm9AAmHI9y3mcGY4ZNQqPKp2PtwSJVzKcNN+rmjAu4TwFMgHHGVhw0ov+f/QywfUvSwtllFWrpo9iw3mqNnVzHqOnEse9xwA/g2Jg+gqpzPvbOVULEl5gI4hlsGpw49Dia3qHHxXQyj60vAN4MbBYvQvvJDyXwR07Md/9RWQO/2mW+9Ez5wnzzPDQvEmvhQW6m7/0L+uDVvv7Eis7Tmt4zK17KyBk18EOlrqCpc1KY8ihho1MPxMnbufrSoah58hQI7wxOGUPboBW/IMyvQprXZgQJhd4JGnJO/x1gEANpgcErxgIG1wLDhkI0zn/+qAkvIdTol15yHBOKxKLilN0Qp/iLJ9otNqw7+AMYYmhmMDk8O9gaqNe5vi0K9Vem1bqnwN8twt2ZP3ZeRq1vUePjJGsOOZ4DilMhzIiFg6ZIb0m2FdmrpO2V2PI8uHTm5uTRmZcd7PzaBSIfcpwIeHHMryH6J/TlzitZvhmaIxFV5/xInP8c6SimVQhDWJi++Xz+SMZLBhvL35w0vPcCwa66B3BSQSbQzpKsQ44cLyPo3V/IkeMFx/8AWG1QNzeVS5EAAAAASUVORK5CYII="
                        alt="Logo"
                    /></a>
                  </div>
                  <p class="footer-item__desc">
                    It is a long established fact that a reader will be
                    distracted
                  </p>
                  <h6 class="footer-item__title mt-4 mt-lg-5">
                    Lets Work Together
                  </h6>
                  <div class="row gy-4">
                    <div class="col-6">
                      <div class="contact-info d-flex gap-2">
                        <span class="contact-info__icon text-gradient"
                          ><i class="fas fa-map-marker-alt"></i
                        ></span>
                        <div class="contact-info__content">
                          <span class="contact-info__text text-white"
                            >Address</span
                          ><span class="contact-info__address text-white"
                            >66 Broklyant, New York India</span
                          >
                        </div>
                      </div>
                    </div>
                    <div class="col-6">
                      <div class="contact-info d-flex gap-2">
                        <span class="contact-info__icon text-gradient"
                          ><i class="fas fa-phone"></i
                        ></span>
                        <div class="contact-info__content">
                          <span class="contact-info__text text-white"
                            >Phone Number</span
                          ><span class="contact-info__address text-white"
                            >012 345 678 9101</span
                          >
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-xl-1 d-xl-block d-none"></div>
              <div class="col-xl-3 col-sm-6">
                <div class="footer-item">
                  <h6 class="footer-item__title">Services</h6>
                  <ul class="footer-menu">
                    <li class="footer-menu__item">
                      <a
                        class="footer-menu__link"
                        href="https://cityscape.wowtheme7.com/property"
                        >Reliable Rentals
                      </a>
                    </li>
                    <li class="footer-menu__item">
                      <a
                        class="footer-menu__link"
                        href="https://cityscape.wowtheme7.com/property"
                        >Golden Key Properties
                      </a>
                    </li>
                    <li class="footer-menu__item">
                      <a
                        class="footer-menu__link"
                        href="https://cityscape.wowtheme7.com/property"
                        >Swift Home Sales
                      </a>
                    </li>
                    <li class="footer-menu__item">
                      <a
                        class="footer-menu__link"
                        href="https://cityscape.wowtheme7.com/property"
                        >Elite Realty Services
                      </a>
                    </li>
                    <li class="footer-menu__item">
                      <a
                        class="footer-menu__link"
                        href="https://cityscape.wowtheme7.com/property"
                        >Dream Property Solutions
                      </a>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="col-xl-1 d-xl-block d-none"></div>
              <div class="col-xl-3 col-sm-6">
                <div class="footer-item">
                  <h6 class="footer-item__title">Subscribe</h6>
                  <p class="footer-item__desc">
                    It is a long established fact that reader will be Elite
                    Property
                  </p>
                  <form
                    action="https://cityscape.wowtheme7.com/#"
                    class="mt-4 subscribe-box"
                  >
                    <div class="input-group">
                      <input
                        type="text"
                        class="form-control common-input common-input--md text-white"
                        placeholder="Your mail address"
                      /><button
                        type="submit"
                        class="px-4 input-group-text bg--gradient border-0 text-white"
                      >
                        <i class="fas fa-paper-plane"></i>
                      </button>
                    </div>
                  </form>
                  <ul class="social-list">
                    <li class="social-list__item">
                      <a
                        class="social-list__link flx-center"
                        href="https://www.facebook.com/"
                        ><i class="fab fa-facebook-f"></i
                      ></a>
                    </li>
                    <li class="social-list__item">
                      <a
                        class="social-list__link flx-center"
                        href="https://www.twitter.com/"
                        ><i class="fab fa-twitter"></i
                      ></a>
                    </li>
                    <li class="social-list__item">
                      <a
                        class="social-list__link flx-center"
                        href="https://www.linkedin.com/"
                        ><i class="fab fa-linkedin-in"></i
                      ></a>
                    </li>
                    <li class="social-list__item">
                      <a
                        class="social-list__link flx-center"
                        href="https://www.pinterest.com/"
                        ><i class="fab fa-instagram"></i
                      ></a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </footer>
        <div class="bottom-footer">
          <div class="container container-two">
            <div class="bottom-footer__inner flx-between gap-3">
              <p class="bottom-footer__text">
                © CityScape 2025 | All Rights Reserved.
              </p>
              <div class="footer-links">
                <a
                  class="footer-link"
                  href="https://cityscape.wowtheme7.com/contact"
                  >Terms &amp; Condition</a
                ><a
                  class="footer-link"
                  href="https://cityscape.wowtheme7.com/contact"
                  >Privacy Policy</a
                ><a
                  class="footer-link"
                  href="https://cityscape.wowtheme7.com/contact"
                  >Contact Us</a
                >
              </div>
            </div>
          </div>
        </div>
      </main>
      <div class="scrollToTop" style="visibility: hidden">
        <i class="fas fa-chevron-up text-gradient"></i>
      </div>
    </div>

    <!-- Bootstrap Bundle Js -->
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
  </body>
  <ddict-div style="visibility: visible !important"
    ><template shadowrootmode="open"
      ><style>
        *,
        :before,
        :after {
          box-sizing: border-box;
          border-width: 0;
          border-style: solid;
          border-color: #e5e7eb;
        }
        :before,
        :after {
          --tw-content: "";
        }
        html,
        :host {
          line-height: 1.5;
          -webkit-text-size-adjust: 100%;
          -moz-tab-size: 4;
          -o-tab-size: 4;
          tab-size: 4;
          font-family: ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji",
            "Segoe UI Emoji", Segoe UI Symbol, "Noto Color Emoji";
          font-feature-settings: normal;
          font-variation-settings: normal;
          -webkit-tap-highlight-color: transparent;
        }
        body {
          margin: 0;
          line-height: inherit;
        }
        hr {
          height: 0;
          color: inherit;
          border-top-width: 1px;
        }
        abbr:where([title]) {
          -webkit-text-decoration: underline dotted;
          text-decoration: underline dotted;
        }
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
          font-size: inherit;
          font-weight: inherit;
        }
        a {
          color: inherit;
          text-decoration: inherit;
        }
        b,
        strong {
          font-weight: bolder;
        }
        code,
        kbd,
        samp,
        pre {
          font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas,
            Liberation Mono, Courier New, monospace;
          font-feature-settings: normal;
          font-variation-settings: normal;
          font-size: 1em;
        }
        small {
          font-size: 80%;
        }
        sub,
        sup {
          font-size: 75%;
          line-height: 0;
          position: relative;
          vertical-align: baseline;
        }
        sub {
          bottom: -0.25em;
        }
        sup {
          top: -0.5em;
        }
        table {
          text-indent: 0;
          border-color: inherit;
          border-collapse: collapse;
        }
        button,
        input,
        optgroup,
        select,
        textarea {
          font-family: inherit;
          font-feature-settings: inherit;
          font-variation-settings: inherit;
          font-size: 100%;
          font-weight: inherit;
          line-height: inherit;
          letter-spacing: inherit;
          color: inherit;
          margin: 0;
          padding: 0;
        }
        button,
        select {
          text-transform: none;
        }
        button,
        input:where([type="button"]),
        input:where([type="reset"]),
        input:where([type="submit"]) {
          -webkit-appearance: button;
          background-color: transparent;
          background-image: none;
        }
        :-moz-focusring {
          outline: auto;
        }
        :-moz-ui-invalid {
          box-shadow: none;
        }
        progress {
          vertical-align: baseline;
        }
        ::-webkit-inner-spin-button,
        ::-webkit-outer-spin-button {
          height: auto;
        }
        [type="search"] {
          -webkit-appearance: textfield;
          outline-offset: -2px;
        }
        ::-webkit-search-decoration {
          -webkit-appearance: none;
        }
        ::-webkit-file-upload-button {
          -webkit-appearance: button;
          font: inherit;
        }
        summary {
          display: list-item;
        }
        blockquote,
        dl,
        dd,
        h1,
        h2,
        h3,
        h4,
        h5,
        h6,
        hr,
        figure,
        p,
        pre {
          margin: 0;
        }
        fieldset {
          margin: 0;
          padding: 0;
        }
        legend {
          padding: 0;
        }
        ol,
        ul,
        menu {
          list-style: none;
          margin: 0;
          padding: 0;
        }
        dialog {
          padding: 0;
        }
        textarea {
          resize: vertical;
        }
        input::-moz-placeholder,
        textarea::-moz-placeholder {
          opacity: 1;
          color: #9ca3af;
        }
        input::placeholder,
        textarea::placeholder {
          opacity: 1;
          color: #9ca3af;
        }
        button,
        [role="button"] {
          cursor: pointer;
        }
        :disabled {
          cursor: default;
        }
        img,
        svg,
        video,
        canvas,
        audio,
        iframe,
        embed,
        object {
          display: block;
          vertical-align: middle;
        }
        img,
        video {
          max-width: 100%;
          height: auto;
        }
        [hidden] {
          display: none;
        }
        :root,
        [data-theme] {
          background-color: var(--fallback-b1, oklch(var(--b1) / 1));
          color: var(--fallback-bc, oklch(var(--bc) / 1));
        }
        @supports not (color: oklch(0% 0 0)) {
          :root {
            color-scheme: light;
            --fallback-p: #491eff;
            --fallback-pc: #d4dbff;
            --fallback-s: #ff41c7;
            --fallback-sc: #fff9fc;
            --fallback-a: #00cfbd;
            --fallback-ac: #00100d;
            --fallback-n: #2b3440;
            --fallback-nc: #d7dde4;
            --fallback-b1: #ffffff;
            --fallback-b2: #e5e6e6;
            --fallback-b3: #e5e6e6;
            --fallback-bc: #1f2937;
            --fallback-in: #00b3f0;
            --fallback-inc: #000000;
            --fallback-su: #00ca92;
            --fallback-suc: #000000;
            --fallback-wa: #ffc22d;
            --fallback-wac: #000000;
            --fallback-er: #ff6f70;
            --fallback-erc: #000000;
          }
          @media (prefers-color-scheme: dark) {
            :root {
              color-scheme: dark;
              --fallback-p: #7582ff;
              --fallback-pc: #050617;
              --fallback-s: #ff71cf;
              --fallback-sc: #190211;
              --fallback-a: #00c7b5;
              --fallback-ac: #000e0c;
              --fallback-n: #2a323c;
              --fallback-nc: #a6adbb;
              --fallback-b1: #1d232a;
              --fallback-b2: #191e24;
              --fallback-b3: #15191e;
              --fallback-bc: #a6adbb;
              --fallback-in: #00b3f0;
              --fallback-inc: #000000;
              --fallback-su: #00ca92;
              --fallback-suc: #000000;
              --fallback-wa: #ffc22d;
              --fallback-wac: #000000;
              --fallback-er: #ff6f70;
              --fallback-erc: #000000;
            }
          }
        }
        html {
          -webkit-tap-highlight-color: transparent;
        }
        * {
          scrollbar-color: color-mix(in oklch, currentColor 35%, transparent)
            transparent;
        }
        *:hover {
          scrollbar-color: color-mix(in oklch, currentColor 60%, transparent)
            transparent;
        }
        :root {
          color-scheme: light;
          --in: 72.06% 0.191 231.6;
          --su: 64.8% 0.15 160;
          --wa: 84.71% 0.199 83.87;
          --er: 71.76% 0.221 22.18;
          --pc: 89.824% 0.06192 275.75;
          --ac: 15.352% 0.0368 183.61;
          --inc: 0% 0 0;
          --suc: 0% 0 0;
          --wac: 0% 0 0;
          --erc: 0% 0 0;
          --rounded-box: 1rem;
          --rounded-btn: 0.5rem;
          --rounded-badge: 1.9rem;
          --animation-btn: 0.25s;
          --animation-input: 0.2s;
          --btn-focus-scale: 0.95;
          --border-btn: 1px;
          --tab-border: 1px;
          --tab-radius: 0.5rem;
          --p: 49.12% 0.3096 275.75;
          --s: 69.71% 0.329 342.55;
          --sc: 98.71% 0.0106 342.55;
          --a: 76.76% 0.184 183.61;
          --n: 32.1785% 0.02476 255.701624;
          --nc: 89.4994% 0.011585 252.096176;
          --b1: 100% 0 0;
          --b2: 96.1151% 0 0;
          --b3: 92.4169% 0.00108 197.137559;
          --bc: 27.8078% 0.029596 256.847952;
        }
        @media (prefers-color-scheme: dark) {
          :root {
            color-scheme: dark;
            --in: 72.06% 0.191 231.6;
            --su: 64.8% 0.15 160;
            --wa: 84.71% 0.199 83.87;
            --er: 71.76% 0.221 22.18;
            --pc: 13.138% 0.0392 275.75;
            --sc: 14.96% 0.052 342.55;
            --ac: 14.902% 0.0334 183.61;
            --inc: 0% 0 0;
            --suc: 0% 0 0;
            --wac: 0% 0 0;
            --erc: 0% 0 0;
            --rounded-box: 1rem;
            --rounded-btn: 0.5rem;
            --rounded-badge: 1.9rem;
            --animation-btn: 0.25s;
            --animation-input: 0.2s;
            --btn-focus-scale: 0.95;
            --border-btn: 1px;
            --tab-border: 1px;
            --tab-radius: 0.5rem;
            --p: 65.69% 0.196 275.75;
            --s: 74.8% 0.26 342.55;
            --a: 74.51% 0.167 183.61;
            --n: 31.3815% 0.021108 254.139175;
            --nc: 74.6477% 0.0216 264.435964;
            --b1: 25.3267% 0.015896 252.417568;
            --b2: 23.2607% 0.013807 253.100675;
            --b3: 21.1484% 0.01165 254.087939;
            --bc: 74.6477% 0.0216 264.435964;
          }
        }
        [data-theme="light"] {
          color-scheme: light;
          --in: 72.06% 0.191 231.6;
          --su: 64.8% 0.15 160;
          --wa: 84.71% 0.199 83.87;
          --er: 71.76% 0.221 22.18;
          --pc: 89.824% 0.06192 275.75;
          --ac: 15.352% 0.0368 183.61;
          --inc: 0% 0 0;
          --suc: 0% 0 0;
          --wac: 0% 0 0;
          --erc: 0% 0 0;
          --rounded-box: 1rem;
          --rounded-btn: 0.5rem;
          --rounded-badge: 1.9rem;
          --animation-btn: 0.25s;
          --animation-input: 0.2s;
          --btn-focus-scale: 0.95;
          --border-btn: 1px;
          --tab-border: 1px;
          --tab-radius: 0.5rem;
          --p: 49.12% 0.3096 275.75;
          --s: 69.71% 0.329 342.55;
          --sc: 98.71% 0.0106 342.55;
          --a: 76.76% 0.184 183.61;
          --n: 32.1785% 0.02476 255.701624;
          --nc: 89.4994% 0.011585 252.096176;
          --b1: 100% 0 0;
          --b2: 96.1151% 0 0;
          --b3: 92.4169% 0.00108 197.137559;
          --bc: 27.8078% 0.029596 256.847952;
        }
        [data-theme="dark"] {
          color-scheme: dark;
          --in: 72.06% 0.191 231.6;
          --su: 64.8% 0.15 160;
          --wa: 84.71% 0.199 83.87;
          --er: 71.76% 0.221 22.18;
          --pc: 13.138% 0.0392 275.75;
          --sc: 14.96% 0.052 342.55;
          --ac: 14.902% 0.0334 183.61;
          --inc: 0% 0 0;
          --suc: 0% 0 0;
          --wac: 0% 0 0;
          --erc: 0% 0 0;
          --rounded-box: 1rem;
          --rounded-btn: 0.5rem;
          --rounded-badge: 1.9rem;
          --animation-btn: 0.25s;
          --animation-input: 0.2s;
          --btn-focus-scale: 0.95;
          --border-btn: 1px;
          --tab-border: 1px;
          --tab-radius: 0.5rem;
          --p: 65.69% 0.196 275.75;
          --s: 74.8% 0.26 342.55;
          --a: 74.51% 0.167 183.61;
          --n: 31.3815% 0.021108 254.139175;
          --nc: 74.6477% 0.0216 264.435964;
          --b1: 25.3267% 0.015896 252.417568;
          --b2: 23.2607% 0.013807 253.100675;
          --b3: 21.1484% 0.01165 254.087939;
          --bc: 74.6477% 0.0216 264.435964;
        }
        *,
        :before,
        :after {
          --tw-border-spacing-x: 0;
          --tw-border-spacing-y: 0;
          --tw-translate-x: 0;
          --tw-translate-y: 0;
          --tw-rotate: 0;
          --tw-skew-x: 0;
          --tw-skew-y: 0;
          --tw-scale-x: 1;
          --tw-scale-y: 1;
          --tw-pan-x: ;
          --tw-pan-y: ;
          --tw-pinch-zoom: ;
          --tw-scroll-snap-strictness: proximity;
          --tw-gradient-from-position: ;
          --tw-gradient-via-position: ;
          --tw-gradient-to-position: ;
          --tw-ordinal: ;
          --tw-slashed-zero: ;
          --tw-numeric-figure: ;
          --tw-numeric-spacing: ;
          --tw-numeric-fraction: ;
          --tw-ring-inset: ;
          --tw-ring-offset-width: 0px;
          --tw-ring-offset-color: #fff;
          --tw-ring-color: rgb(59 130 246 / 0.5);
          --tw-ring-offset-shadow: 0 0 #0000;
          --tw-ring-shadow: 0 0 #0000;
          --tw-shadow: 0 0 #0000;
          --tw-shadow-colored: 0 0 #0000;
          --tw-blur: ;
          --tw-brightness: ;
          --tw-contrast: ;
          --tw-grayscale: ;
          --tw-hue-rotate: ;
          --tw-invert: ;
          --tw-saturate: ;
          --tw-sepia: ;
          --tw-drop-shadow: ;
          --tw-backdrop-blur: ;
          --tw-backdrop-brightness: ;
          --tw-backdrop-contrast: ;
          --tw-backdrop-grayscale: ;
          --tw-backdrop-hue-rotate: ;
          --tw-backdrop-invert: ;
          --tw-backdrop-opacity: ;
          --tw-backdrop-saturate: ;
          --tw-backdrop-sepia: ;
          --tw-contain-size: ;
          --tw-contain-layout: ;
          --tw-contain-paint: ;
          --tw-contain-style: ;
        }
        ::backdrop {
          --tw-border-spacing-x: 0;
          --tw-border-spacing-y: 0;
          --tw-translate-x: 0;
          --tw-translate-y: 0;
          --tw-rotate: 0;
          --tw-skew-x: 0;
          --tw-skew-y: 0;
          --tw-scale-x: 1;
          --tw-scale-y: 1;
          --tw-pan-x: ;
          --tw-pan-y: ;
          --tw-pinch-zoom: ;
          --tw-scroll-snap-strictness: proximity;
          --tw-gradient-from-position: ;
          --tw-gradient-via-position: ;
          --tw-gradient-to-position: ;
          --tw-ordinal: ;
          --tw-slashed-zero: ;
          --tw-numeric-figure: ;
          --tw-numeric-spacing: ;
          --tw-numeric-fraction: ;
          --tw-ring-inset: ;
          --tw-ring-offset-width: 0px;
          --tw-ring-offset-color: #fff;
          --tw-ring-color: rgb(59 130 246 / 0.5);
          --tw-ring-offset-shadow: 0 0 #0000;
          --tw-ring-shadow: 0 0 #0000;
          --tw-shadow: 0 0 #0000;
          --tw-shadow-colored: 0 0 #0000;
          --tw-blur: ;
          --tw-brightness: ;
          --tw-contrast: ;
          --tw-grayscale: ;
          --tw-hue-rotate: ;
          --tw-invert: ;
          --tw-saturate: ;
          --tw-sepia: ;
          --tw-drop-shadow: ;
          --tw-backdrop-blur: ;
          --tw-backdrop-brightness: ;
          --tw-backdrop-contrast: ;
          --tw-backdrop-grayscale: ;
          --tw-backdrop-hue-rotate: ;
          --tw-backdrop-invert: ;
          --tw-backdrop-opacity: ;
          --tw-backdrop-saturate: ;
          --tw-backdrop-sepia: ;
          --tw-contain-size: ;
          --tw-contain-layout: ;
          --tw-contain-paint: ;
          --tw-contain-style: ;
        }
        .avatar.placeholder > div {
          display: flex;
          align-items: center;
          justify-content: center;
        }
        @media (hover: hover) {
          .link-hover:hover {
            text-decoration-line: underline;
          }
          .label a:hover {
            --tw-text-opacity: 1;
            color: var(
              --fallback-bc,
              oklch(var(--bc) / var(--tw-text-opacity))
            );
          }
        }
        .btn {
          display: inline-flex;
          height: 3rem;
          min-height: 3rem;
          flex-shrink: 0;
          cursor: pointer;
          -webkit-user-select: none;
          -moz-user-select: none;
          user-select: none;
          flex-wrap: wrap;
          align-items: center;
          justify-content: center;
          border-radius: var(--rounded-btn, 0.5rem);
          border-color: transparent;
          border-color: oklch(
            var(--btn-color, var(--b2)) / var(--tw-border-opacity)
          );
          padding-left: 1rem;
          padding-right: 1rem;
          text-align: center;
          font-size: 0.875rem;
          line-height: 1em;
          gap: 0.5rem;
          font-weight: 600;
          text-decoration-line: none;
          transition-duration: 0.2s;
          transition-timing-function: cubic-bezier(0, 0, 0.2, 1);
          border-width: var(--border-btn, 1px);
          transition-property: color, background-color, border-color, opacity,
            box-shadow, transform;
          --tw-text-opacity: 1;
          color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
          --tw-shadow: 0 1px 2px 0 rgb(0 0 0 / 0.05);
          --tw-shadow-colored: 0 1px 2px 0 var(--tw-shadow-color);
          box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
            var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
          outline-color: var(--fallback-bc, oklch(var(--bc) / 1));
          background-color: oklch(
            var(--btn-color, var(--b2)) / var(--tw-bg-opacity)
          );
          --tw-bg-opacity: 1;
          --tw-border-opacity: 1;
        }
        .btn-disabled,
        .btn[disabled],
        .btn:disabled {
          pointer-events: none;
        }
        .btn-circle {
          height: 3rem;
          width: 3rem;
          border-radius: 9999px;
          padding: 0;
        }
        :where(.btn:is(input[type="checkbox"])),
        :where(.btn:is(input[type="radio"])) {
          width: auto;
          -webkit-appearance: none;
          -moz-appearance: none;
          appearance: none;
        }
        .btn:is(input[type="checkbox"]):after,
        .btn:is(input[type="radio"]):after {
          --tw-content: attr(aria-label);
          content: var(--tw-content);
        }
        .card {
          position: relative;
          display: flex;
          flex-direction: column;
          border-radius: var(--rounded-box, 1rem);
        }
        .card:focus {
          outline: 2px solid transparent;
          outline-offset: 2px;
        }
        .card-body {
          display: flex;
          flex: 1 1 auto;
          flex-direction: column;
          padding: var(--padding-card, 2rem);
          gap: 0.5rem;
        }
        .card-body :where(p) {
          flex-grow: 1;
        }
        .card figure {
          display: flex;
          align-items: center;
          justify-content: center;
        }
        .card.image-full {
          display: grid;
        }
        .card.image-full:before {
          position: relative;
          content: "";
          z-index: 10;
          border-radius: var(--rounded-box, 1rem);
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-n,
            oklch(var(--n) / var(--tw-bg-opacity))
          );
          opacity: 0.75;
        }
        .card.image-full:before,
        .card.image-full > * {
          grid-column-start: 1;
          grid-row-start: 1;
        }
        .card.image-full > figure img {
          height: 100%;
          -o-object-fit: cover;
          object-fit: cover;
        }
        .card.image-full > .card-body {
          position: relative;
          z-index: 20;
          --tw-text-opacity: 1;
          color: var(--fallback-nc, oklch(var(--nc) / var(--tw-text-opacity)));
        }
        @media (hover: hover) {
          .btm-nav > *.\!disabled:hover {
            pointer-events: none !important;
            --tw-border-opacity: 0 !important;
            background-color: var(
              --fallback-n,
              oklch(var(--n) / var(--tw-bg-opacity))
            ) !important;
            --tw-bg-opacity: 0.1 !important;
            color: var(
              --fallback-bc,
              oklch(var(--bc) / var(--tw-text-opacity))
            ) !important;
            --tw-text-opacity: 0.2 !important;
          }
          .btm-nav > *.disabled:hover,
          .btm-nav > *[disabled]:hover {
            pointer-events: none;
            --tw-border-opacity: 0;
            background-color: var(
              --fallback-n,
              oklch(var(--n) / var(--tw-bg-opacity))
            );
            --tw-bg-opacity: 0.1;
            color: var(
              --fallback-bc,
              oklch(var(--bc) / var(--tw-text-opacity))
            );
            --tw-text-opacity: 0.2;
          }
          .btn:hover {
            --tw-border-opacity: 1;
            border-color: var(
              --fallback-b3,
              oklch(var(--b3) / var(--tw-border-opacity))
            );
            --tw-bg-opacity: 1;
            background-color: var(
              --fallback-b3,
              oklch(var(--b3) / var(--tw-bg-opacity))
            );
          }
          @supports (color: color-mix(in oklab, black, black)) {
            .btn:hover {
              background-color: color-mix(
                in oklab,
                oklch(var(--btn-color, var(--b2)) / var(--tw-bg-opacity, 1)) 90%,
                black
              );
              border-color: color-mix(
                in oklab,
                oklch(var(--btn-color, var(--b2)) / var(--tw-border-opacity, 1))
                  90%,
                black
              );
            }
          }
          @supports not (color: oklch(0% 0 0)) {
            .btn:hover {
              background-color: var(--btn-color, var(--fallback-b2));
              border-color: var(--btn-color, var(--fallback-b2));
            }
          }
          .btn.glass:hover {
            --glass-opacity: 25%;
            --glass-border-opacity: 15%;
          }
          .btn-ghost:hover {
            border-color: transparent;
          }
          @supports (color: oklch(0% 0 0)) {
            .btn-ghost:hover {
              background-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
            }
          }
          .btn-outline.btn-primary:hover {
            --tw-text-opacity: 1;
            color: var(
              --fallback-pc,
              oklch(var(--pc) / var(--tw-text-opacity))
            );
          }
          @supports (color: color-mix(in oklab, black, black)) {
            .btn-outline.btn-primary:hover {
              background-color: color-mix(
                in oklab,
                var(--fallback-p, oklch(var(--p) / 1)) 90%,
                black
              );
              border-color: color-mix(
                in oklab,
                var(--fallback-p, oklch(var(--p) / 1)) 90%,
                black
              );
            }
          }
          .btn-disabled:hover,
          .btn[disabled]:hover,
          .btn:disabled:hover {
            --tw-border-opacity: 0;
            background-color: var(
              --fallback-n,
              oklch(var(--n) / var(--tw-bg-opacity))
            );
            --tw-bg-opacity: 0.2;
            color: var(
              --fallback-bc,
              oklch(var(--bc) / var(--tw-text-opacity))
            );
            --tw-text-opacity: 0.2;
          }
          @supports (color: color-mix(in oklab, black, black)) {
            .btn:is(input[type="checkbox"]:checked):hover,
            .btn:is(input[type="radio"]:checked):hover {
              background-color: color-mix(
                in oklab,
                var(--fallback-p, oklch(var(--p) / 1)) 90%,
                black
              );
              border-color: color-mix(
                in oklab,
                var(--fallback-p, oklch(var(--p) / 1)) 90%,
                black
              );
            }
          }
        }
        .form-control {
          display: flex;
          flex-direction: column;
        }
        .label {
          display: flex;
          -webkit-user-select: none;
          -moz-user-select: none;
          user-select: none;
          align-items: center;
          justify-content: space-between;
          padding: 0.5rem 0.25rem;
        }
        .hero {
          display: grid;
          width: 100%;
          place-items: center;
          background-size: cover;
          background-position: center;
        }
        .hero > * {
          grid-column-start: 1;
          grid-row-start: 1;
        }
        .hero-content {
          z-index: 0;
          display: flex;
          align-items: center;
          justify-content: center;
          max-width: 80rem;
          gap: 1rem;
          padding: 1rem;
        }
        .input {
          flex-shrink: 1;
          -webkit-appearance: none;
          -moz-appearance: none;
          appearance: none;
          height: 3rem;
          padding-left: 1rem;
          padding-right: 1rem;
          font-size: 1rem;
          line-height: 2;
          line-height: 1.5rem;
          border-radius: var(--rounded-btn, 0.5rem);
          border-width: 1px;
          border-color: transparent;
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-b1,
            oklch(var(--b1) / var(--tw-bg-opacity))
          );
        }
        .input[type="number"]::-webkit-inner-spin-button,
        .input-md[type="number"]::-webkit-inner-spin-button {
          margin-top: -1rem;
          margin-bottom: -1rem;
          margin-inline-end: -1rem;
        }
        .join {
          display: inline-flex;
          align-items: stretch;
          border-radius: var(--rounded-btn, 0.5rem);
        }
        .join :where(.join-item) {
          border-start-end-radius: 0;
          border-end-end-radius: 0;
          border-end-start-radius: 0;
          border-start-start-radius: 0;
        }
        .join .join-item:not(:first-child):not(:last-child),
        .join *:not(:first-child):not(:last-child) .join-item {
          border-start-end-radius: 0;
          border-end-end-radius: 0;
          border-end-start-radius: 0;
          border-start-start-radius: 0;
        }
        .join .join-item:first-child:not(:last-child),
        .join *:first-child:not(:last-child) .join-item {
          border-start-end-radius: 0;
          border-end-end-radius: 0;
        }
        .join .dropdown .join-item:first-child:not(:last-child),
        .join *:first-child:not(:last-child) .dropdown .join-item {
          border-start-end-radius: inherit;
          border-end-end-radius: inherit;
        }
        .join :where(.join-item:first-child:not(:last-child)),
        .join :where(*:first-child:not(:last-child) .join-item) {
          border-end-start-radius: inherit;
          border-start-start-radius: inherit;
        }
        .join .join-item:last-child:not(:first-child),
        .join *:last-child:not(:first-child) .join-item {
          border-end-start-radius: 0;
          border-start-start-radius: 0;
        }
        .join :where(.join-item:last-child:not(:first-child)),
        .join :where(*:last-child:not(:first-child) .join-item) {
          border-start-end-radius: inherit;
          border-end-end-radius: inherit;
        }
        @supports not selector(has(*)) {
          :where(.join *) {
            border-radius: inherit;
          }
        }
        @supports selector(:has(*)) {
          :where(.join *:has(.join-item)) {
            border-radius: inherit;
          }
        }
        .link {
          cursor: pointer;
          text-decoration-line: underline;
        }
        .link-hover {
          text-decoration-line: none;
        }
        .mask {
          -webkit-mask-size: contain;
          mask-size: contain;
          -webkit-mask-repeat: no-repeat;
          mask-repeat: no-repeat;
          -webkit-mask-position: center;
          mask-position: center;
        }
        .menu li.\!disabled {
          cursor: not-allowed !important;
          -webkit-user-select: none !important;
          -moz-user-select: none !important;
          user-select: none !important;
          color: var(--fallback-bc, oklch(var(--bc) / 0.3)) !important;
        }
        .menu li.disabled {
          cursor: not-allowed;
          -webkit-user-select: none;
          -moz-user-select: none;
          user-select: none;
          color: var(--fallback-bc, oklch(var(--bc) / 0.3));
        }
        .textarea {
          min-height: 3rem;
          flex-shrink: 1;
          padding: 0.5rem 1rem;
          font-size: 0.875rem;
          line-height: 1.25rem;
          line-height: 2;
          border-radius: var(--rounded-btn, 0.5rem);
          border-width: 1px;
          border-color: transparent;
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-b1,
            oklch(var(--b1) / var(--tw-bg-opacity))
          );
        }
        .toggle {
          flex-shrink: 0;
          --tglbg: var(--fallback-b1, oklch(var(--b1) / 1));
          --handleoffset: 1.5rem;
          --handleoffsetcalculator: calc(var(--handleoffset) * -1);
          --togglehandleborder: 0 0;
          height: 1.5rem;
          width: 3rem;
          cursor: pointer;
          -webkit-appearance: none;
          -moz-appearance: none;
          appearance: none;
          border-radius: var(--rounded-badge, 1.9rem);
          border-width: 1px;
          border-color: currentColor;
          background-color: currentColor;
          color: var(--fallback-bc, oklch(var(--bc) / 0.5));
          transition: background,
            box-shadow var(--animation-input, 0.2s) ease-out;
          box-shadow: var(--handleoffsetcalculator) 0 0 2px var(--tglbg) inset,
            0 0 0 2px var(--tglbg) inset, var(--togglehandleborder);
        }
        .btm-nav > *.\!disabled {
          pointer-events: none !important;
          --tw-border-opacity: 0 !important;
          background-color: var(
            --fallback-n,
            oklch(var(--n) / var(--tw-bg-opacity))
          ) !important;
          --tw-bg-opacity: 0.1 !important;
          color: var(
            --fallback-bc,
            oklch(var(--bc) / var(--tw-text-opacity))
          ) !important;
          --tw-text-opacity: 0.2 !important;
        }
        .btm-nav > *.disabled,
        .btm-nav > *[disabled] {
          pointer-events: none;
          --tw-border-opacity: 0;
          background-color: var(
            --fallback-n,
            oklch(var(--n) / var(--tw-bg-opacity))
          );
          --tw-bg-opacity: 0.1;
          color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
          --tw-text-opacity: 0.2;
        }
        .btm-nav > * .label {
          font-size: 1rem;
          line-height: 1.5rem;
        }
        @media (prefers-reduced-motion: no-preference) {
          .btn {
            animation: button-pop var(--animation-btn, 0.25s) ease-out;
          }
        }
        .btn:active:hover,
        .btn:active:focus {
          animation: button-pop 0s ease-out;
          transform: scale(var(--btn-focus-scale, 0.97));
        }
        @supports not (color: oklch(0% 0 0)) {
          .btn {
            background-color: var(--btn-color, var(--fallback-b2));
            border-color: var(--btn-color, var(--fallback-b2));
          }
          .btn-primary {
            --btn-color: var(--fallback-p);
          }
        }
        @supports (color: color-mix(in oklab, black, black)) {
          .btn-outline.btn-primary.btn-active {
            background-color: color-mix(
              in oklab,
              var(--fallback-p, oklch(var(--p) / 1)) 90%,
              black
            );
            border-color: color-mix(
              in oklab,
              var(--fallback-p, oklch(var(--p) / 1)) 90%,
              black
            );
          }
        }
        .btn:focus-visible {
          outline-style: solid;
          outline-width: 2px;
          outline-offset: 2px;
        }
        .btn-primary {
          --tw-text-opacity: 1;
          color: var(--fallback-pc, oklch(var(--pc) / var(--tw-text-opacity)));
          outline-color: var(--fallback-p, oklch(var(--p) / 1));
        }
        @supports (color: oklch(0% 0 0)) {
          .btn-primary {
            --btn-color: var(--p);
          }
        }
        .btn.glass {
          --tw-shadow: 0 0 #0000;
          --tw-shadow-colored: 0 0 #0000;
          box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
            var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
          outline-color: currentColor;
        }
        .btn.glass.btn-active {
          --glass-opacity: 25%;
          --glass-border-opacity: 15%;
        }
        .btn-ghost {
          border-width: 1px;
          border-color: transparent;
          background-color: transparent;
          color: currentColor;
          --tw-shadow: 0 0 #0000;
          --tw-shadow-colored: 0 0 #0000;
          box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
            var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
          outline-color: currentColor;
        }
        .btn-ghost.btn-active {
          border-color: transparent;
          background-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
        }
        .btn-outline.btn-primary {
          --tw-text-opacity: 1;
          color: var(--fallback-p, oklch(var(--p) / var(--tw-text-opacity)));
        }
        .btn-outline.btn-primary.btn-active {
          --tw-text-opacity: 1;
          color: var(--fallback-pc, oklch(var(--pc) / var(--tw-text-opacity)));
        }
        .btn.btn-disabled,
        .btn[disabled],
        .btn:disabled {
          --tw-border-opacity: 0;
          background-color: var(
            --fallback-n,
            oklch(var(--n) / var(--tw-bg-opacity))
          );
          --tw-bg-opacity: 0.2;
          color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
          --tw-text-opacity: 0.2;
        }
        .btn:is(input[type="checkbox"]:checked),
        .btn:is(input[type="radio"]:checked) {
          --tw-border-opacity: 1;
          border-color: var(
            --fallback-p,
            oklch(var(--p) / var(--tw-border-opacity))
          );
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-p,
            oklch(var(--p) / var(--tw-bg-opacity))
          );
          --tw-text-opacity: 1;
          color: var(--fallback-pc, oklch(var(--pc) / var(--tw-text-opacity)));
        }
        .btn:is(input[type="checkbox"]:checked):focus-visible,
        .btn:is(input[type="radio"]:checked):focus-visible {
          outline-color: var(--fallback-p, oklch(var(--p) / 1));
        }
        @keyframes button-pop {
          0% {
            transform: scale(var(--btn-focus-scale, 0.98));
          }
          40% {
            transform: scale(1.02);
          }
          to {
            transform: scale(1);
          }
        }
        .card :where(figure:first-child) {
          overflow: hidden;
          border-start-start-radius: inherit;
          border-start-end-radius: inherit;
          border-end-start-radius: unset;
          border-end-end-radius: unset;
        }
        .card :where(figure:last-child) {
          overflow: hidden;
          border-start-start-radius: unset;
          border-start-end-radius: unset;
          border-end-start-radius: inherit;
          border-end-end-radius: inherit;
        }
        .card:focus-visible {
          outline: 2px solid currentColor;
          outline-offset: 2px;
        }
        .card.bordered {
          border-width: 1px;
          --tw-border-opacity: 1;
          border-color: var(
            --fallback-b2,
            oklch(var(--b2) / var(--tw-border-opacity))
          );
        }
        .card.compact .card-body {
          padding: 1rem;
          font-size: 0.875rem;
          line-height: 1.25rem;
        }
        .card.image-full :where(figure) {
          overflow: hidden;
          border-radius: inherit;
        }
        @keyframes checkmark {
          0% {
            background-position-y: 5px;
          }
          50% {
            background-position-y: -2px;
          }
          to {
            background-position-y: 0;
          }
        }
        .label-text {
          font-size: 0.875rem;
          line-height: 1.25rem;
          --tw-text-opacity: 1;
          color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
        }
        .label-text-alt {
          font-size: 0.75rem;
          line-height: 1rem;
          --tw-text-opacity: 1;
          color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
        }
        .input input {
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-p,
            oklch(var(--p) / var(--tw-bg-opacity))
          );
          background-color: transparent;
        }
        .input input:focus {
          outline: 2px solid transparent;
          outline-offset: 2px;
        }
        .input[list]::-webkit-calendar-picker-indicator {
          line-height: 1em;
        }
        .input-bordered {
          border-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
        }
        .input:focus,
        .input:focus-within {
          box-shadow: none;
          border-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
          outline-style: solid;
          outline-width: 2px;
          outline-offset: 2px;
          outline-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
        }
        .input:has(> input[disabled]),
        .input-disabled,
        .input:disabled,
        .input[disabled] {
          cursor: not-allowed;
          --tw-border-opacity: 1;
          border-color: var(
            --fallback-b2,
            oklch(var(--b2) / var(--tw-border-opacity))
          );
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-b2,
            oklch(var(--b2) / var(--tw-bg-opacity))
          );
          color: var(--fallback-bc, oklch(var(--bc) / 0.4));
        }
        .input:has(> input[disabled])::-moz-placeholder,
        .input-disabled::-moz-placeholder,
        .input:disabled::-moz-placeholder,
        .input[disabled]::-moz-placeholder {
          color: var(
            --fallback-bc,
            oklch(var(--bc) / var(--tw-placeholder-opacity))
          );
          --tw-placeholder-opacity: 0.2;
        }
        .input:has(> input[disabled])::placeholder,
        .input-disabled::placeholder,
        .input:disabled::placeholder,
        .input[disabled]::placeholder {
          color: var(
            --fallback-bc,
            oklch(var(--bc) / var(--tw-placeholder-opacity))
          );
          --tw-placeholder-opacity: 0.2;
        }
        .input:has(> input[disabled]) > input[disabled] {
          cursor: not-allowed;
        }
        .input::-webkit-date-and-time-value {
          text-align: inherit;
        }
        .join > :where(*:not(:first-child)) {
          margin-top: 0;
          margin-bottom: 0;
          margin-inline-start: -1px;
        }
        .join > :where(*:not(:first-child)):is(.btn) {
          margin-inline-start: calc(var(--border-btn) * -1);
        }
        .link:focus {
          outline: 2px solid transparent;
          outline-offset: 2px;
        }
        .link:focus-visible {
          outline: 2px solid currentColor;
          outline-offset: 2px;
        }
        .mockup-phone .display {
          overflow: hidden;
          border-radius: 40px;
          margin-top: -25px;
        }
        .mockup-browser .mockup-browser-toolbar .input {
          position: relative;
          margin-left: auto;
          margin-right: auto;
          display: block;
          height: 1.75rem;
          width: 24rem;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-b2,
            oklch(var(--b2) / var(--tw-bg-opacity))
          );
          padding-left: 2rem;
          direction: ltr;
        }
        .mockup-browser .mockup-browser-toolbar .input:before {
          content: "";
          position: absolute;
          left: 0.5rem;
          top: 50%;
          aspect-ratio: 1 / 1;
          height: 0.75rem;
          --tw-translate-y: -50%;
          transform: translate(var(--tw-translate-x), var(--tw-translate-y))
            rotate(var(--tw-rotate)) skew(var(--tw-skew-x))
            skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x))
            scaleY(var(--tw-scale-y));
          border-radius: 9999px;
          border-width: 2px;
          border-color: currentColor;
          opacity: 0.6;
        }
        .mockup-browser .mockup-browser-toolbar .input:after {
          content: "";
          position: absolute;
          left: 1.25rem;
          top: 50%;
          height: 0.5rem;
          --tw-translate-y: 25%;
          --tw-rotate: -45deg;
          transform: translate(var(--tw-translate-x), var(--tw-translate-y))
            rotate(var(--tw-rotate)) skew(var(--tw-skew-x))
            skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x))
            scaleY(var(--tw-scale-y));
          border-radius: 9999px;
          border-width: 1px;
          border-color: currentColor;
          opacity: 0.6;
        }
        @keyframes modal-pop {
          0% {
            opacity: 0;
          }
        }
        @keyframes progress-loading {
          50% {
            background-position-x: -115%;
          }
        }
        @keyframes radiomark {
          0% {
            box-shadow: 0 0 0 12px var(--fallback-b1, oklch(var(--b1) / 1))
                inset,
              0 0 0 12px var(--fallback-b1, oklch(var(--b1) / 1)) inset;
          }
          50% {
            box-shadow: 0 0 0 3px var(--fallback-b1, oklch(var(--b1) / 1)) inset,
              0 0 0 3px var(--fallback-b1, oklch(var(--b1) / 1)) inset;
          }
          to {
            box-shadow: 0 0 0 4px var(--fallback-b1, oklch(var(--b1) / 1)) inset,
              0 0 0 4px var(--fallback-b1, oklch(var(--b1) / 1)) inset;
          }
        }
        @keyframes rating-pop {
          0% {
            transform: translateY(-0.125em);
          }
          40% {
            transform: translateY(-0.125em);
          }
          to {
            transform: translateY(0);
          }
        }
        @keyframes skeleton {
          0% {
            background-position: 150%;
          }
          to {
            background-position: -50%;
          }
        }
        .textarea:focus {
          box-shadow: none;
          border-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
          outline-style: solid;
          outline-width: 2px;
          outline-offset: 2px;
          outline-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
        }
        .textarea-primary {
          --tw-border-opacity: 1;
          border-color: var(
            --fallback-p,
            oklch(var(--p) / var(--tw-border-opacity))
          );
        }
        .textarea-primary:focus {
          --tw-border-opacity: 1;
          border-color: var(
            --fallback-p,
            oklch(var(--p) / var(--tw-border-opacity))
          );
          outline-color: var(--fallback-p, oklch(var(--p) / 1));
        }
        .textarea-disabled,
        .textarea:disabled,
        .textarea[disabled] {
          cursor: not-allowed;
          --tw-border-opacity: 1;
          border-color: var(
            --fallback-b2,
            oklch(var(--b2) / var(--tw-border-opacity))
          );
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-b2,
            oklch(var(--b2) / var(--tw-bg-opacity))
          );
          color: var(--fallback-bc, oklch(var(--bc) / 0.4));
        }
        .textarea-disabled::-moz-placeholder,
        .textarea:disabled::-moz-placeholder,
        .textarea[disabled]::-moz-placeholder {
          color: var(
            --fallback-bc,
            oklch(var(--bc) / var(--tw-placeholder-opacity))
          );
          --tw-placeholder-opacity: 0.2;
        }
        .textarea-disabled::placeholder,
        .textarea:disabled::placeholder,
        .textarea[disabled]::placeholder {
          color: var(
            --fallback-bc,
            oklch(var(--bc) / var(--tw-placeholder-opacity))
          );
          --tw-placeholder-opacity: 0.2;
        }
        @keyframes toast-pop {
          0% {
            transform: scale(0.9);
            opacity: 0;
          }
          to {
            transform: scale(1);
            opacity: 1;
          }
        }
        [dir="rtl"] .toggle {
          --handleoffsetcalculator: calc(var(--handleoffset) * 1);
        }
        .toggle:focus-visible {
          outline-style: solid;
          outline-width: 2px;
          outline-offset: 2px;
          outline-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
        }
        .toggle:hover {
          background-color: currentColor;
        }
        .toggle:checked,
        .toggle[aria-checked="true"] {
          background-image: none;
          --handleoffsetcalculator: var(--handleoffset);
          --tw-text-opacity: 1;
          color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
        }
        [dir="rtl"] .toggle:checked,
        [dir="rtl"] .toggle[aria-checked="true"] {
          --handleoffsetcalculator: calc(var(--handleoffset) * -1);
        }
        .toggle:indeterminate {
          --tw-text-opacity: 1;
          color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
          box-shadow: calc(var(--handleoffset) / 2) 0 0 2px var(--tglbg) inset,
            calc(var(--handleoffset) / -2) 0 0 2px var(--tglbg) inset,
            0 0 0 2px var(--tglbg) inset;
        }
        [dir="rtl"] .toggle:indeterminate {
          box-shadow: calc(var(--handleoffset) / 2) 0 0 2px var(--tglbg) inset,
            calc(var(--handleoffset) / -2) 0 0 2px var(--tglbg) inset,
            0 0 0 2px var(--tglbg) inset;
        }
        .toggle:disabled {
          cursor: not-allowed;
          --tw-border-opacity: 1;
          border-color: var(
            --fallback-bc,
            oklch(var(--bc) / var(--tw-border-opacity))
          );
          background-color: transparent;
          opacity: 0.3;
          --togglehandleborder: 0 0 0 3px
              var(--fallback-bc, oklch(var(--bc) / 1)) inset,
            var(--handleoffsetcalculator) 0 0 3px
              var(--fallback-bc, oklch(var(--bc) / 1)) inset;
        }
        .btn-xs {
          height: 1.5rem;
          min-height: 1.5rem;
          padding-left: 0.5rem;
          padding-right: 0.5rem;
          font-size: 0.75rem;
        }
        .btn-square:where(.btn-xs) {
          height: 1.5rem;
          width: 1.5rem;
          padding: 0;
        }
        .btn-circle:where(.btn-xs) {
          height: 1.5rem;
          width: 1.5rem;
          border-radius: 9999px;
          padding: 0;
        }
        .btn-circle:where(.btn-sm) {
          height: 2rem;
          width: 2rem;
          border-radius: 9999px;
          padding: 0;
        }
        .btn-circle:where(.btn-md) {
          height: 3rem;
          width: 3rem;
          border-radius: 9999px;
          padding: 0;
        }
        .btn-circle:where(.btn-lg) {
          height: 4rem;
          width: 4rem;
          border-radius: 9999px;
          padding: 0;
        }
        .join.join-vertical {
          flex-direction: column;
        }
        .join.join-vertical .join-item:first-child:not(:last-child),
        .join.join-vertical *:first-child:not(:last-child) .join-item {
          border-end-start-radius: 0;
          border-end-end-radius: 0;
          border-start-start-radius: inherit;
          border-start-end-radius: inherit;
        }
        .join.join-vertical .join-item:last-child:not(:first-child),
        .join.join-vertical *:last-child:not(:first-child) .join-item {
          border-start-start-radius: 0;
          border-start-end-radius: 0;
          border-end-start-radius: inherit;
          border-end-end-radius: inherit;
        }
        .join.join-horizontal {
          flex-direction: row;
        }
        .join.join-horizontal .join-item:first-child:not(:last-child),
        .join.join-horizontal *:first-child:not(:last-child) .join-item {
          border-end-end-radius: 0;
          border-start-end-radius: 0;
          border-end-start-radius: inherit;
          border-start-start-radius: inherit;
        }
        .join.join-horizontal .join-item:last-child:not(:first-child),
        .join.join-horizontal *:last-child:not(:first-child) .join-item {
          border-end-start-radius: 0;
          border-start-start-radius: 0;
          border-end-end-radius: inherit;
          border-start-end-radius: inherit;
        }
        .tooltip {
          position: relative;
          display: inline-block;
          --tooltip-offset: calc(100% + 1px + var(--tooltip-tail, 0px));
        }
        .tooltip:before {
          position: absolute;
          pointer-events: none;
          z-index: 1;
          content: var(--tw-content);
          --tw-content: attr(data-tip);
        }
        .tooltip:before,
        .tooltip-top:before {
          transform: translate(-50%);
          top: auto;
          left: 50%;
          right: auto;
          bottom: var(--tooltip-offset);
        }
        .card-compact .card-body {
          padding: 1rem;
          font-size: 0.875rem;
          line-height: 1.25rem;
        }
        .card-normal .card-body {
          padding: var(--padding-card, 2rem);
          font-size: 1rem;
          line-height: 1.5rem;
        }
        .join.join-vertical > :where(*:not(:first-child)) {
          margin-left: 0;
          margin-right: 0;
          margin-top: -1px;
        }
        .join.join-vertical > :where(*:not(:first-child)):is(.btn) {
          margin-top: calc(var(--border-btn) * -1);
        }
        .join.join-horizontal > :where(*:not(:first-child)) {
          margin-top: 0;
          margin-bottom: 0;
          margin-inline-start: -1px;
        }
        .join.join-horizontal > :where(*:not(:first-child)):is(.btn) {
          margin-inline-start: calc(var(--border-btn) * -1);
        }
        .tooltip {
          position: relative;
          display: inline-block;
          text-align: center;
          --tooltip-tail: 0.1875rem;
          --tooltip-color: var(--fallback-n, oklch(var(--n) / 1));
          --tooltip-text-color: var(--fallback-nc, oklch(var(--nc) / 1));
          --tooltip-tail-offset: calc(100% + 0.0625rem - var(--tooltip-tail));
        }
        .tooltip:before,
        .tooltip:after {
          opacity: 0;
          transition-property: color, background-color, border-color,
            text-decoration-color, fill, stroke, opacity, box-shadow, transform,
            filter, -webkit-backdrop-filter;
          transition-property: color, background-color, border-color,
            text-decoration-color, fill, stroke, opacity, box-shadow, transform,
            filter, backdrop-filter;
          transition-property: color, background-color, border-color,
            text-decoration-color, fill, stroke, opacity, box-shadow, transform,
            filter, backdrop-filter, -webkit-backdrop-filter;
          transition-delay: 0.1s;
          transition-duration: 0.2s;
          transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
        }
        .tooltip:after {
          position: absolute;
          content: "";
          border-style: solid;
          border-width: var(--tooltip-tail, 0);
          width: 0;
          height: 0;
          display: block;
        }
        .tooltip:before {
          max-width: 20rem;
          white-space: normal;
          border-radius: 0.25rem;
          padding: 0.25rem 0.5rem;
          font-size: 0.875rem;
          line-height: 1.25rem;
          background-color: var(--tooltip-color);
          color: var(--tooltip-text-color);
          width: -moz-max-content;
          width: max-content;
        }
        .tooltip.tooltip-open:before {
          opacity: 1;
          transition-delay: 75ms;
        }
        .tooltip.tooltip-open:after {
          opacity: 1;
          transition-delay: 75ms;
        }
        .tooltip:hover:before {
          opacity: 1;
          transition-delay: 75ms;
        }
        .tooltip:hover:after {
          opacity: 1;
          transition-delay: 75ms;
        }
        .tooltip:has(:focus-visible):after,
        .tooltip:has(:focus-visible):before {
          opacity: 1;
          transition-delay: 75ms;
        }
        .tooltip:not([data-tip]):hover:before,
        .tooltip:not([data-tip]):hover:after {
          visibility: hidden;
          opacity: 0;
        }
        .tooltip:after,
        .tooltip-top:after {
          transform: translate(-50%);
          border-color: var(--tooltip-color) transparent transparent transparent;
          top: auto;
          left: 50%;
          right: auto;
          bottom: var(--tooltip-tail-offset);
        }
        .absolute {
          position: absolute;
        }
        .relative {
          position: relative;
        }
        .inset-0 {
          top: 0;
          right: 0;
          bottom: 0;
          left: 0;
        }
        .z-10 {
          z-index: 10;
        }
        .m-0 {
          margin: 0;
        }
        .mb-1 {
          margin-bottom: 0.25rem;
        }
        .mr-2 {
          margin-right: 0.5rem;
        }
        .mt-2 {
          margin-top: 0.5rem;
        }
        .mt-6 {
          margin-top: 1.5rem;
        }
        .block {
          display: block;
        }
        .flex {
          display: flex;
        }
        .h-6 {
          height: 1.5rem;
        }
        .min-h-screen {
          min-height: 100vh;
        }
        .w-12 {
          width: 3rem;
        }
        .w-5 {
          width: 1.25rem;
        }
        .w-6 {
          width: 1.5rem;
        }
        .w-full {
          width: 100%;
        }
        .max-w-sm {
          max-width: 24rem;
        }
        .flex-shrink-0 {
          flex-shrink: 0;
        }
        .transform {
          transform: translate(var(--tw-translate-x), var(--tw-translate-y))
            rotate(var(--tw-rotate)) skew(var(--tw-skew-x))
            skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x))
            scaleY(var(--tw-scale-y));
        }
        @keyframes moveGradient {
          0%,
          to {
            background-position: 0% 50%;
          }
          50% {
            background-position: 100% 50%;
          }
        }
        .animate-moveGradient {
          animation: moveGradient 4s alternate infinite;
        }
        .cursor-pointer {
          cursor: pointer;
        }
        .list-inside {
          list-style-position: inside;
        }
        .list-outside {
          list-style-position: outside;
        }
        .list-decimal {
          list-style-type: decimal;
        }
        .list-disc {
          list-style-type: disc;
        }
        .list-none {
          list-style-type: none;
        }
        .flex-row {
          flex-direction: row;
        }
        .flex-col {
          flex-direction: column;
        }
        .items-center {
          align-items: center;
        }
        .justify-start {
          justify-content: flex-start;
        }
        .justify-end {
          justify-content: flex-end;
        }
        .justify-center {
          justify-content: center;
        }
        .justify-between {
          justify-content: space-between;
        }
        .gap-1 {
          gap: 0.25rem;
        }
        .gap-2 {
          gap: 0.5rem;
        }
        .rounded-lg {
          border-radius: 0.5rem;
        }
        .rounded-md {
          border-radius: 0.375rem;
        }
        .border {
          border-width: 1px;
        }
        .border-t {
          border-top-width: 1px;
        }
        .border-solid {
          border-style: solid;
        }
        .\!border-none {
          border-style: none !important;
        }
        .border-\[\#D3D4D9\] {
          --tw-border-opacity: 1;
          border-color: rgb(211 212 217 / var(--tw-border-opacity));
        }
        .border-neutral-300 {
          --tw-border-opacity: 1;
          border-color: rgb(212 212 212 / var(--tw-border-opacity));
        }
        .\!bg-transparent {
          background-color: transparent !important;
        }
        .\!bg-white {
          --tw-bg-opacity: 1 !important;
          background-color: rgb(255 255 255 / var(--tw-bg-opacity)) !important;
        }
        .bg-base-100 {
          --tw-bg-opacity: 1;
          background-color: var(
            --fallback-b1,
            oklch(var(--b1) / var(--tw-bg-opacity))
          );
        }
        .bg-gray-100 {
          --tw-bg-opacity: 1;
          background-color: rgb(243 244 246 / var(--tw-bg-opacity));
        }
        .bg-white {
          --tw-bg-opacity: 1;
          background-color: rgb(255 255 255 / var(--tw-bg-opacity));
        }
        .bg-gradient-to-br {
          background-image: linear-gradient(
            to bottom right,
            var(--tw-gradient-stops)
          );
        }
        .from-\[\#8556f0\] {
          --tw-gradient-from: #8556f0 var(--tw-gradient-from-position);
          --tw-gradient-to: rgb(133 86 240 / 0) var(--tw-gradient-to-position);
          --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
        }
        .via-\[\#6bedd1\] {
          --tw-gradient-to: rgb(107 237 209 / 0) var(--tw-gradient-to-position);
          --tw-gradient-stops: var(--tw-gradient-from),
            #6bedd1 var(--tw-gradient-via-position), var(--tw-gradient-to);
        }
        .via-\[\#d6b379\] {
          --tw-gradient-to: rgb(214 179 121 / 0) var(--tw-gradient-to-position);
          --tw-gradient-stops: var(--tw-gradient-from),
            #d6b379 var(--tw-gradient-via-position), var(--tw-gradient-to);
        }
        .to-\[\#439beb\] {
          --tw-gradient-to: #439beb var(--tw-gradient-to-position);
        }
        .bg-\[length\:300\%_300\%\] {
          background-size: 300% 300%;
        }
        .bg-\[position\:0\%_50\%\] {
          background-position: 0% 50%;
        }
        .p-0 {
          padding: 0;
        }
        .p-0\.5 {
          padding: 0.125rem;
        }
        .p-1 {
          padding: 0.25rem;
        }
        .p-2 {
          padding: 0.5rem;
        }
        .p-3 {
          padding: 0.75rem;
        }
        .py-6 {
          padding-top: 1.5rem;
          padding-bottom: 1.5rem;
        }
        .pb-1 {
          padding-bottom: 0.25rem;
        }
        .pt-0 {
          padding-top: 0;
        }
        .pt-2 {
          padding-top: 0.5rem;
        }
        .text-center {
          text-align: center;
        }
        .text-5xl {
          font-size: 3rem;
          line-height: 1;
        }
        .text-base {
          font-size: 1rem;
          line-height: 1.5rem;
        }
        .text-sm {
          font-size: 0.875rem;
          line-height: 1.25rem;
        }
        .text-xs {
          font-size: 0.75rem;
          line-height: 1rem;
        }
        .font-bold {
          font-weight: 700;
        }
        .font-normal {
          font-weight: 400;
        }
        .capitalize {
          text-transform: capitalize;
        }
        .italic {
          font-style: italic;
        }
        .leading-6 {
          line-height: 1.5rem;
        }
        .leading-tight {
          line-height: 1.25;
        }
        .text-primary {
          --tw-text-opacity: 1;
          color: var(--fallback-p, oklch(var(--p) / var(--tw-text-opacity)));
        }
        .text-slate-400 {
          --tw-text-opacity: 1;
          color: rgb(148 163 184 / var(--tw-text-opacity));
        }
        .text-slate-900 {
          --tw-text-opacity: 1;
          color: rgb(15 23 42 / var(--tw-text-opacity));
        }
        .text-textCustom {
          --tw-text-opacity: 1;
          color: rgb(26 31 42 / var(--tw-text-opacity));
        }
        .opacity-100 {
          opacity: 1;
        }
        .opacity-50 {
          opacity: 0.5;
        }
        .\!shadow-none {
          --tw-shadow: 0 0 #0000 !important;
          --tw-shadow-colored: 0 0 #0000 !important;
          box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
            var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow) !important;
        }
        .shadow-2xl {
          --tw-shadow: 0 25px 50px -12px rgb(0 0 0 / 0.25);
          --tw-shadow-colored: 0 25px 50px -12px var(--tw-shadow-color);
          box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
            var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
        }
        .shadow-lg {
          --tw-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1),
            0 4px 6px -4px rgb(0 0 0 / 0.1);
          --tw-shadow-colored: 0 10px 15px -3px var(--tw-shadow-color),
            0 4px 6px -4px var(--tw-shadow-color);
          box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
            var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
        }
        .\!ring-0 {
          --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0
            var(--tw-ring-offset-width) var(--tw-ring-offset-color) !important;
          --tw-ring-shadow: var(--tw-ring-inset) 0 0 0
            calc(0px + var(--tw-ring-offset-width)) var(--tw-ring-color) !important;
          box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow),
            var(--tw-shadow, 0 0 #0000) !important;
        }
        body {
          width: 200%;
        }
        .before\:\!bottom-\[100\%\]:before {
          content: var(--tw-content);
          bottom: 100% !important;
        }
        .before\:\!rounded-md:before {
          content: var(--tw-content);
          border-radius: 0.375rem !important;
        }
        .before\:\!border:before {
          content: var(--tw-content);
          border-width: 1px !important;
        }
        .before\:\!border-solid:before {
          content: var(--tw-content);
          border-style: solid !important;
        }
        .before\:\!border-gray-200:before {
          content: var(--tw-content);
          --tw-border-opacity: 1 !important;
          border-color: rgb(229 231 235 / var(--tw-border-opacity)) !important;
        }
        .before\:\!bg-white:before {
          content: var(--tw-content);
          --tw-bg-opacity: 1 !important;
          background-color: rgb(255 255 255 / var(--tw-bg-opacity)) !important;
        }
        .before\:\!text-textSecondary:before {
          content: var(--tw-content);
          --tw-text-opacity: 1 !important;
          color: rgb(61 68 81 / var(--tw-text-opacity)) !important;
        }
        .before\:\!\[box-shadow\:0px_1px_8px_0px_\#3D44514D\]:before {
          content: var(--tw-content);
          box-shadow: 0 1px 8px #3d44514d !important;
        }
        .after\:\!border-transparent:after {
          content: var(--tw-content);
          border-color: transparent !important;
        }
        @media (min-width: 1024px) {
          .lg\:flex-row-reverse {
            flex-direction: row-reverse;
          }
          .lg\:text-left {
            text-align: left;
          }
        }
        .shadow-custom[data-v-a0957544] {
          box-shadow: 0 0 2rem #0003;
        }</style
      ><ddict-div data-v-app=""
        ><!---->
        <div></div></ddict-div></template
  ></ddict-div>
</html>
