window.crawler.header = {
  init: function() {
    this.bindClickToEmail();
  },

  bindClickToEmail: function() {
    $('.dropdown').click(function() {
      if($('.dropdown-menu').is(':visible')) {
        $('.dropdown-menu').hide();
      } else {
        $('.dropdown-menu').show();
      }
    })
  }
}
