// 공통 IntersectionObserver 생성 함수
function createObserver(className) {
    return new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add(className);
            }
        });
    });
}

// 요소와 적용할 클래스를 매핑
const elementsToObserve = [
    { elements: document.querySelectorAll('.main_infor_in div'), className: 'fadeIn' },
    { elements: document.querySelectorAll('.main_news_in a'), className: 'fadeInUp' },
    { elements: [document.querySelector('.online_txt')], className: 'SideAnim' },
    { elements: [document.querySelector('.online img')], className: 'fadeIn' },
    { elements: [document.querySelector('.MW_status1')], className: 'LeftAnim' },
    { elements: [document.querySelector('.MW_status2')], className: 'fadeIn' },
    { elements: [document.querySelector('.main_offline_tit')], className: 'fadeIn' },
    { elements: [document.querySelector('.main_offline_info')], className: 'fadeInUp' }
];

// 각 요소에 대해 옵저버 생성 및 등록
elementsToObserve.forEach((item) => {
    const observer = createObserver(item.className);
    item.elements.forEach((element) => {
        observer.observe(element);
    });
});