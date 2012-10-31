$(document).ready(function () {

    // Solve Z-index problem in Internet Explorer 7
    $(function () {
        var zIndexNumber = 1000;
        $('div span').each(function () {
            $(this).css('zIndex', zIndexNumber);
            zIndexNumber -= 10;
        });
    });
	
	
	// Progress bar				
	var progress_key = '';

	$(document).ready(function() {
		$("#pb1").progressBar({ barImage: './images/progress.png', showText: true} );
	});



    // close button
   	$('#contact .close').click(function () { $('#contact').animate({ height: "toggle", "bottom": "20" }, "medium"); return false; 			});


    // Show contact form when clicked
    $('#icons .contacts').click(function () { $('#contact').animate({ "height": "toggle", "bottom": "14" }, "medium"); return false; });

// Contact Form
			$("#contact-form").submit(function(){
				var str = $(this).serialize();
				
				//show the loader
				$(".bar").show();
				$(".button").hide();
				
				$.ajax({
				   type: "POST",
				   url: "./php/send.php",
				   data: str,
				   success: function(msg)
				   {
						$("#formstatus").ajaxComplete(function(event, request, settings){
							if(msg == 'OK'){ // Message Sent? Show the 'Thank You' message and hide the form
								result = '<div class="formstatusok">Your message has been sent. Thank you!</div>';
								$("#fields").hide();
								$(".bar").hide();
								$('#contact').delay(700).animate({ height: "toggle", "bottom": "20" }, "medium");
							}
							else{
								result = msg;
								$(".bar").hide();
								$(".button").show();
							}
							$(this).html(result);
						});
					}
				 });
				return false;
			});


		

// Start AJAX Subscriber Form JS

	var options = { 
	target:  '#warning'
	}; 
	$('#newsletter-form').ajaxForm(options); 

	
// Subscribers Form AJAX Loader Image

		$(".loader").hide();
		
		$('form#newsletter-form').bind('submit', function(e){
			$(".loader").show();
					var mail = $('input#email').val();
			e.preventDefault();
			
			$.ajax({
				type: 'POST',
				url: 'subscriber.php',
				data: '',
				success: function(theResponse){
					$(".loader").hide();
				},
				error: function(){
					$(".loader").hide();
				}		
			});
		});
});
