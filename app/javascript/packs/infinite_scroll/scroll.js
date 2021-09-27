$(()=>{
  
  function debounce(func, timeout=500){
    let timer;
    return (...args) =>{
      clearTimeout(timer)
      timer = setTimeout(() => { func.apply(this, args) }, timeout)
    }
  }
  const bottom_scroll = $(window).on("scroll", ()=>{
      if (($(window).innerHeight() + $(window).scrollTop()) >= $("body").height()) {
        next_posts = $(".pagination").find(".next_page").attr("href")
        console.log(next_posts)
        if (next_posts){
          $.getScript(next_posts)
        }
      }
    })
  
    debounce(()=> bottom_scroll)
})