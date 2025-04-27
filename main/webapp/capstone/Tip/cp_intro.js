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


