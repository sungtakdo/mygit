package kopo.aisw.basic_mvc.board.vo;

import java.util.Date;
    public class BoardVO {
    private int articleNO;
    private String title;
    private String content;
    private Date writeDate;
        public int getArticleNO() {
            return articleNO;
        }
        public void setArticleNO(int articleNO) {
            this.articleNO = articleNO;
        }
        public String getTitle() {
            return title;
        }
        public void setTitle(String title) {
            this.title = title;
        }
        public String getContent() {
            return content;
        }
        public void setContent(String content) {
            this.content = content;
        }
        public Date getWriteDate() {
            return writeDate;
        }
        public void setWriteDate(Date writeDate) {
            this.writeDate = writeDate;
        }
    }

