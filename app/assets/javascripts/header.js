window.crawler.header = {
  init: function() {
    this.bindClickToEmail();
    this.bindClickToLoader();
  },

  bindClickToEmail: function() {
    $('.dropdown').click(function() {
      if($('.dropdown-menu').is(':visible')) {
        $('.dropdown-menu').hide();
      } else {
        $('.dropdown-menu').show();
      }
    })
  },

  bindClickToLoader: function(event) {
    $('.btn-crawl').click(function(){
      var url_value = this.form.crawl_url.value;
      if (url_value == "") return;
      if (url_value.search('https') < 0 ){
        alert('Please enter the URL with https');
        this.form.crawl_url.value = "";
        return
      }
      if (url_value.search('product') < 0 ){
        alert('Please enter a correct URL ');
        this.form.crawl_url.value = "";
        return
      }

      $(this).text('Starting Crawl');
      $('.mainbox').html(`Starting Crawl. Please Wait,
        You will be automatically redirected to the results page once finished.`);
      $('.loader').show();
    })
  }
}
