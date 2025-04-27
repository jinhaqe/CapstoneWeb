window.onload = function() {
    var menuItems = document.querySelectorAll('.li_dropdown');
    menuItems.forEach(function(item) {
        item.addEventListener('mouseenter', function() {
            var dropdown = this.querySelector('ul');
            dropdown.style.display = 'block';
        });

        item.addEventListener('mouseleave', function() {
            var dropdown = this.querySelector('ul');
            dropdown.style.display = 'none';
        });
    });
};


document.addEventListener('DOMContentLoaded', function () {
    let currentIndex = 0;
    const slides = document.querySelectorAll('.main_slide_in');
    const totalSlides = slides.length;

    function showSlide(index) {
        slides.forEach((slide, i) => {
            slide.style.opacity = (i === index) ? '1' : '0';
            slide.style.zIndex = (i === index) ? '1' : '0';
        });
    }

    function nextSlide() {
        currentIndex = (currentIndex + 1) % totalSlides;
        showSlide(currentIndex);
    }

    // 초기 슬라이드 표시
    showSlide(currentIndex);

    // 5초마다 슬라이드 전환
    setInterval(nextSlide, 5000);
});