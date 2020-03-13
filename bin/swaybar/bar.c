#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <time.h> 

#include "plugins/vwrl.h"

struct tm *current_time;

struct tm *get_time() {
    time_t curtime = time (NULL);
    return localtime (&curtime);
}

void create_block(char *buf, char *text) {
    sprintf(buf, "{\"full_text\": \"%s\"}", text);
}

void get_financial_markets_block(char buf[]) {
    char plugin_buf[256];
    vwrl_info(plugin_buf);
    create_block(buf, plugin_buf);
}

void get_time_block(char buf[]) {
    char time_str[64];
    strftime(time_str, 64, "%Y-%m-%d %l:%M:%S %p", current_time);
    create_block(buf, time_str);
}

int main() {
   

    char *str = "{\"version\": 1}";
    puts(str);
   
    char time_block_buf[64] = { '\0' };
    char financial_markets_buf[512] = { '\0' };
    puts("[");
    while (1) {
        current_time = get_time();
        get_time_block(time_block_buf);
        
        // only update financial markets block once per hour
        if (current_time->tm_min == 0 || strlen(financial_markets_buf) == 0) {
            get_financial_markets_block(financial_markets_buf);
        }

        printf("[%s, %s],\n", financial_markets_buf, time_block_buf);

        fflush(stdout);
        sleep(1);
    }
    puts("]");
}