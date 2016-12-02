window.crawler.table = {
  init: function() {
    this.bindClickToClickableTrs();
  },

  bindClickToClickableTrs: function() {
    $(document).on("click", "tr[data-href]", function() {
      document.location = $(this).data('href');
    });
  }
}
