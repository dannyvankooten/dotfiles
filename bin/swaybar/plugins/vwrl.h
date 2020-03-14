
#include <stdio.h>
#include <curl/curl.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

struct Page {
    char * buf;
    size_t size;
    char * address;
};

static size_t download(void *contents, size_t size, size_t nmemb, void *userp)
{
  size_t realsize = size * nmemb;
  struct Page *mem = (struct Page *) userp;
 
  char *ptr = realloc(mem->buf, mem->size + realsize + 1);
  if(ptr == NULL) {
    /* out of memory! */ 
    printf("not enough memory (realloc returned NULL)\n");
    return 0;
  }
 
  mem->buf = ptr;
  memcpy(&(mem->buf[mem->size]), contents, realsize);
  mem->size += realsize;
  mem->buf[mem->size] = 0;
  mem->address = ptr;
 
  return realsize;
}

struct Page download_html(char url[]) {
    CURL *curl;
    CURLcode res;

    struct Page chunk;
    chunk.buf = malloc(1);  /* will be grown as needed by the realloc above */ 
    chunk.size = 0;    /* no data at this point */ 
    chunk.address = chunk.buf; 

    curl = curl_easy_init();
    if (!curl)
    {
        printf("Error initialising curl\n");
        return chunk;
    }

    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, download);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *) &chunk);
    curl_easy_setopt(curl, CURL_SOCKET_TIMEOUT, 10);
    #ifdef __APPLE__
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0);
    #endif

    res = curl_easy_perform(curl);
    if (res != CURLE_OK)
    {
        fprintf(stderr, "curl_easy_perform() failed: %s\n",
                curl_easy_strerror(res));
    }

    curl_easy_cleanup(curl);
    return chunk;        
}

/* find first occurence of needle in page buffer */
int find_in_page(struct Page *page, char needle[]) {
    int i;
    int len = strlen(needle);
    for (i=0; i < page->size; i++) {
         if (memcmp(needle, &page->buf[i], len) == 0) {
           return i + len;
        }
    }

    return -1;
}

/* read (double) value between start and end string */
double find_value(struct Page *page, char needle_s[], char needle_e) {
    int i = find_in_page(page, needle_s);
    if (i < 0) {
        return 0.00;
    }

    // read everything up to needle_e into char 
    char buf[BUFSIZ];
    int j;
    for (j=0; i < page->size && page->buf[i] != needle_e && j < BUFSIZ-1; i++) {
        if (page->buf[i] == ',') {
            buf[j++] = '.';
        } else {
            buf[j++] = page->buf[i];
        }
    }
    buf[j++] = '\0';

    // move buffer up to index because we know what we need next comes after what we're looking for now
    page->buf += i;
    page->size -= i;

    return atof(buf);
}

// <span id="ctl00_ctl00_Content_TopContent_IssueDetailBar_RangeBlock52W_lblDayHighPrice">88,11</span>
// basevalues['61114463LastPrice'] = 87.48;
// basevalues['61114463LowPrice'] = 87.48;
// basevalues['61114463HighPrice'] = 87.9;
// basevalues['61114463LastTime'] = 1581591241000; 
// basevalues['61114463AbsoluteDifference'] = -0.59;
// basevalues['61114463RelativeDifference'] = -0.6699;
void vwrl_info(char *buf) {
    struct Page page = download_html("https://www.iex.nl/Beleggingsfonds-Koers/61114463/Vanguard-FTSE-All-World-UCITS-ETF.aspx");
    double ath, last_price, change_today;
    ath = find_value(&page, "<span id=\"ctl00_ctl00_Content_TopContent_IssueDetailBar_RangeBlock52W_lblDayHighPrice\">", '<');
    last_price = find_value(&page, "basevalues['61114463LastPrice'] = ", ';');
    change_today = find_value(&page, "basevalues['61114463RelativeDifference'] = ", ';');
    free(page.address);

    //double change = 0.0;
    double recovery = 0.0;
    if (ath > 0.0 && last_price > 0.0) {
        //change = (last_price / ath - 1.0) * 100.0;      
        recovery = (ath / last_price - 1.0) * 100.0;
    }

    sprintf(buf, "VWRL: €%.2f (%s%.1f%% today). %.1f%% from ATH of €%.2f ", last_price, change_today > 0 ? "+" : "", change_today, recovery, ath);
}

