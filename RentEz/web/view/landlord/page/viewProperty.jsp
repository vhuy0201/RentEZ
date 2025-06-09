<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Rental Properties - RentEz</title>
    <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"/>
    <style>
        .property-list-section {
            padding: 60px 0;
            background: #f5f7fa;
        }
        .property-item {
            border-radius: 1.25rem;
            box-shadow: 0 0 2rem rgba(0, 0, 0, 0.075);
            background: #fff;
            overflow: hidden;
            transition: box-shadow 0.2s ease;
            margin-bottom: 32px;
        }
        .property-item:hover {
            box-shadow: 0 8px 32px rgba(133, 86, 240, 0.2);
        }
        .property-item__thumb img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-radius: 1.25rem 1.25rem 0 0;
        }
        .property-item__content {
            padding: 1.5rem;
        }
        .property-item__title {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .property-item__price {
            font-size: 1.1rem;
            color: #8556f0;
            font-weight: 700;
        }
        .property-item__location {
            color: #439beb;
            font-size: 0.95rem;
            margin-bottom: 0.75rem;
        }
        .property-item__bottom {
            margin-top: 1rem;
        }
        .amenities-list {
            display: flex;
            gap: 1rem;
        }
        .btn-add {
            background: linear-gradient(90deg, #8556f0 0%, #439beb 100%);
            color: #fff;
            border-radius: 0.5rem;
            font-weight: 600;
            border: none;
            padding: 0.5rem 1.5rem;
            transition: background 0.2s;
        }
        .btn-add:hover {
            background: linear-gradient(90deg, #439beb 0%, #8556f0 100%);
        }
        .btn-sm {
            font-size: 0.875rem;
            padding: 0.4rem 0.8rem;
        }
        .additional-images img {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 6px;
            margin-right: 4px;
        }
        .badge {
            font-size: 0.85rem;
            padding: 0.4em 0.8em;
        }
    </style>
</head>
<body>
<div id="root">
    <main class="body-bg">
        <jsp:include page="/view/common/header.jsp" />

        <section class="property-list-section">
            <div class="container container-two">
                <div class="section-heading style-left style-dark d-flex justify-content-between align-items-end gap-3 mb-4">
                    <div class="section-heading__inner">
                        <span class="section-heading__subtitle">
                            <span class="text-gradient fw-semibold">Your Listings</span>
                        </span>
                        <h2 class="section-heading__title">Manage Your Rental Properties</h2>
                    </div>
                    <a href="${pageContext.request.contextPath}/landlord/addProperty" class="btn btn-add">
                        <i class="fas fa-plus me-2"></i>Add New Property
                    </a>
                </div>
                <div class="row gy-4 property-item-wrapper">
                    <c:forEach var="property" items="${properties}">
                        <div class="col-lg-4 col-md-6">
                            <div class="property-item">
                                <div class="property-item__thumb">
                                    <img src="${not empty property.avatar ? property.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/property-1-D5t-zcgy.png')}" 
                                         alt="${property.title} Image" 
                                         loading="lazy"/>
                                </div>
                                <div class="property-item__content">
                                    <h6 class="property-item__price">
                                        $${property.price}<span class="day">/month</span>
                                    </h6>
                                    <h6 class="property-item__title">
                                        <a class="link" href="${pageContext.request.contextPath}/landlord/propertyDetail?id=${property.propertyId}">
                                            ${property.title}
                                        </a>
                                    </h6>
                                    <p class="property-item__location d-flex gap-2">
                                        <span class="icon"><i class="fas fa-map-marker-alt"></i></span>
                                        ${property.location}
                                    </p>
                                    <div class="property-item__bottom d-flex justify-content-between gap-2">
                                        <ul class="amenities-list">
                                            <li class="amenities-list__item d-flex align-items-center">
                                                <span class="icon me-1"><i class="fas fa-expand"></i></span>
                                                <span class="text">${property.size} m²</span>
                                            </li>
                                            <li class="amenities-list__item d-flex align-items-center">
                                                <span class="icon me-1"><i class="fas fa-bed"></i></span>
                                                <span class="text">${property.numberOfBedrooms} Beds</span>
                                            </li>
                                            <li class="amenities-list__item d-flex align-items-center">
                                                <span class="icon me-1"><i class="fas fa-bath"></i></span>
                                                <span class="text">${property.numberOfBathrooms} Baths</span>
                                            </li>
                                        </ul>
                                        <a class="simple-btn align-self-center" href="${pageContext.request.contextPath}/landlord/propertyDetail?id=${property.propertyId}">
                                            View Details <i class="fas fa-arrow-right ms-1"></i>
                                        </a>
                                    </div>
                                    <div class="mt-3 d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/landlord/editProperty?id=${property.propertyId}" class="btn btn-primary btn-sm">
                                            <i class="fas fa-edit me-1"></i> Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/landlord/deleteProperty?id=${property.propertyId}" 
                                           class="btn btn-danger btn-sm" 
                                           onclick="return confirm('Are you sure you want to delete this property?');">
                                            <i class="fas fa-trash me-1"></i> Delete
                                        </a>
                                    </div>
                                    <div class="mt-2">
                                        <span class="badge bg-${property.availabilityStatus == 'Available' ? 'success' : 'secondary'}">
                                            ${property.availabilityStatus}
                                        </span>
                                    </div>
                                    <div class="mt-2 additional-images">
                                        <c:forEach var="image" items="${propertyImages[property.propertyId]}">
                                            <img src="${image.imageURL}" 
                                                 alt="Additional Property Image" 
                                                 loading="lazy"/>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty properties}">
                        <div class="col-12 text-center text-muted py-5">
                            <i class="fas fa-home fa-3x mb-3 text-gradient"></i>
                            <div class="fs-5">You have no properties listed yet.</div>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>

        <jsp:include page="/view/common/footer.jsp" />
    </main>
    <button class="scrollToTop" style="display: none;">
        <i class="fas fa-chevron-up text-gradient"></i>
    </button>
</div>
<script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
<script>
    // Show/hide scroll-to-top button
    window.addEventListener('scroll', () => {
        const scrollButton = document.querySelector('.scrollToTop');
        scrollButton.style.display = window.scrollY > 300 ? 'block' : 'none';
    });

    // Scroll to top on click
    document.querySelector('.scrollToTop').addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
</script>
</body>
</html>