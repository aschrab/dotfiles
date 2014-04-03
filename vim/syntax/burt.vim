syn sync fromstart

syn region detailhead start="^===== Description =====================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Configuration ===================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Bug_Signature ===================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Internal_Workaround =============================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Notes ===========================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Rel_Notes =======================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== ASUPs ===========================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Public_Report ===================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Escalation_Status ===============================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== RCA_Notes =======================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Fix_Report ======================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Code_Review_Notes ===============================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Unit_Test_Plan ==================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Test_Plan =======================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Pubs_Notes ======================================================$" end="^===== "me=s-1 fold
syn region detailhead start="^===== Change_Log ======================================================$" end="^===== "me=s-1 fold

hi def link detailhead Keyword

let b:current_syntax = "burt"
