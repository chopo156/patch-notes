$(document).ready(function() {

    window.addEventListener('message', function(event) {
        var item = event.data;

        if (item.showPlayerMenu == true) {
           $('body').css('display', 'block');
            $('.container-fluid').css('display', 'block');
        } else if (item.showPlayerMenu == false) { 
			$('body').css('display', 'none');
            $('.container-fluid').css('display', 'none');

            if (e.data.displayWindow == 'true') {
                $(".container-fluid").css('display', 'flex');
                  
                $(".container-fluid").animate({
                    bottom: "25%",
                    opacity: "1.0"
                    
                    },
                    700, function() {
                });
        
            } else {
                $(".container-fluid").animate({
                    bottom: "-50%",
                    opacity: "0.0"
                    },
                    700, function() {
                        $(".container-fluid").css('display', 'none');                         
                });
            }

        }
    });

    

    $("#closeClick").click(function() {
        $.post('http://patch-notes/close', JSON.stringify({}));
    });

})


