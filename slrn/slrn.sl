define article_scrolldn()                                                       
{                                                                               
  if (is_article_visible ())                                                    
  {                                                                             
    call ("scroll_dn");                                                         
  }                                                                             
  else  call ("pagedn");                                                        
}                                                                               
                                                                                
define article_scrollup()                                                       
{                                                                               
  if (is_article_visible ())                                                    
  {                                                                             
    call ("scroll_up");                                                         
  }                                                                             
  else  call ("pageup");                                                        
}                                                                               
                                                                                
definekey ("article_scrolldn", " ", "article");     % use nifty slang function  
definekey ("article_scrollup", "b", "article");     % use nifty slang function  
