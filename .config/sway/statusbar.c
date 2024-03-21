#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <errno.h>

#undef BUFSIZ
#define BUFSIZ 1024

char buf[BUFSIZ] = {0};

struct tuple {
  int first;
  int second;
};

typedef struct tuple tuple_t;

static int read_file(char buf[static BUFSIZ], char *filename) {
  FILE *fd = fopen(filename, "r");
  if (!fd) {
    return -1;
  }

  size_t n = fread(buf, 1, BUFSIZ - 1, fd);
  buf[n] = 0;

  fclose(fd);
  return 1;
}

static int get_battery_level(void) {
  if (!read_file(buf, "/sys/class/power_supply/BAT0/capacity")) {
    return 0;
  }
  int battery_lvl = atoi(buf);
  return battery_lvl;
}

static int get_battery_status(void) {
  if (!read_file(buf, "/sys/class/power_supply/BAT0/status")) {
    return 0;
  }
  return buf[0] == 'D' ? -1 : 1;
}

static float get_cpu_load(void) {
  if (!read_file(buf, "/proc/loadavg")) {
    return 0;
  }

  errno = 0;
  float load = strtof(buf, NULL);
  if (errno != 0) {
    return 0.00;
  }

  return load * 100.0 / 16.0;
}

static tuple_t get_memory_info(void) {
  if (!read_file(buf, "/proc/meminfo")) {
    return (tuple_t){0, 0};
  }

  char *needle = "MemTotal:";
  char *s = strstr(buf, needle);
  if (!s) {
    return (tuple_t){0, 0};
  }
  s += strlen(needle);
  int total = atoi(s);

  needle = "MemAvailable:";
  s = strstr(buf, needle);
  if (!s) {
    return (tuple_t){0, 0};
  }
  s += strlen(needle);
  int available = atoi(s);
  return (tuple_t){(total - available) / 1024, total / 1024};
}

static int get_wifi_network_name(char dst[static 64]) {
  FILE *pout = popen("nmcli -t -f \"GENERAL.CONNECTION\" device show", "r");
  if (pout == NULL) {
    return -1;
  }

  char buf[64] = {0};
  fgets(buf, 64, pout);
  int status = pclose(pout);
  if (status != EXIT_SUCCESS) {
    return -1;
  }

  char *s = memchr(buf, ':', 64);
  if (!s) {
    return -1;
  }

  s++; // skip ':'

  if (*s == 0 || *s == '\n') {
    strcpy(dst, "-");
    return 0;
  }


  // copy until newline, at most 63 chars
  unsigned l = 0;
  while (*s != 0 && *s != '\n' && l < 63) {
    dst[l++] = *s++;
  }
  dst[l] = '\0';

  return 0;
}

int main() {
  char time_fmt[64] = {0};
  char ssid[64] = {0};
  int battery;
  char battery_status;
  float cpu_load;
  tuple_t memory_info;
  unsigned t = 0;

  while (1) {
    // only fetch these stats once every 10s
    if (t-- == 0) {
      battery = get_battery_level();
      battery_status = get_battery_status() == -1 ? '-' : '+';
      cpu_load = get_cpu_load();
      memory_info = get_memory_info();
      get_wifi_network_name(ssid);
      t = 10;
    }

    // time every second
    time_t now = time(NULL);
    strftime(time_fmt, 64, "%Y-%m-%d %X", localtime(&now));

    // print & flush stdout
    printf("WIFI %s | CPU %.0f%% | MEM %d / %d MB | BAT %d%% %c%c | %s\n", ssid,
           cpu_load, memory_info.first, memory_info.second, battery,
           battery_status, battery_status, time_fmt);
    fflush(stdout);

    sleep(1);
  }
}
