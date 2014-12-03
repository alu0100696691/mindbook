$('#text').keypress(
  function(e){
    if( e.keyCode==13 ){
      $.get('/send',{text:$('#text').val()});
      $('#text').val('');
    } 
  }
);

(function() {
  var last = 0;
  setInterval(
    function(){
      $.get('/update',{last:last},
        function(response){
          last = $('<p>').html(response).find('span').data('last');
          $('#chat').append(response);
        }
      );
    },
  1000);
  setInterval(                 
    function(){
      $.get('/update/usuarios',{},
        function(response){
                $('#lista').empty();            
                $('#lista').append(response);   
        }
      );
    },
  1000);
})();

function cerrarSession() {
	$.get('/salir');
	$.get('/');
};

$('#enviar').click(
   function(){
      $.get('/send',{text:$('#text').val()});
      $('#text').val('');
   }
);
