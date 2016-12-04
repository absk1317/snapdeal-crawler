window.crawler.header = {
  init: function() {
    this.bindClickToEmail();
    this.bindClickToLoader();
    this.bindSorterToTables();
    this.bindEventToSearchBox();
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
      $(this).text('Starting Crawl');
      $('.mainbox').html("Starting Crawl. Please Wait, You will be automatically redirected to the results page once finished.");
      $('.loader').show();
    })
  },

  bindSorterToTables: function() {
    $("table").tablesorter();
  },

  bindEventToSearchBox: function() {
    var $rows = $('table tr.results');
    $('#searchBox').keyup(function() {
      var val = '^(?=.*\\b' + $.trim($(this).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$',
          reg = RegExp(val, 'i'),
          text;

      $rows.show().filter(function() {
        text = $(this).text().replace(/\s+/g, ' ');
        return !reg.test(text);
      }).hide();
    })
  }
}
