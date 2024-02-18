#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#undef BUFSIZ
#define BUFSIZ 1024

char buf[BUFSIZ];

struct tuple {
    int first;
    int second;
};

typedef struct tuple tuple_t;

int read_file(char *buf, char *filename) {
  FILE *fd = fopen(filename, "r");
  if (!fd) {
    return -1;
  }

  size_t n = fread(buf, 1, BUFSIZ-1, fd);
  buf[n] = 0;

  fclose(fd);
  return 1;
}

int get_battery_level(void) {
  if (!read_file(buf, "/sys/class/power_supply/BAT1/capacity")) {
    return 0;
  }
  int battery_lvl = atoi(buf);
  return battery_lvl;
}

int get_battery_status(void) {
  if (!read_file(buf, "/sys/class/power_supply/BAT1/status")) {
    return 0;
  }
  return buf[0] == 'D' ? -1 : 1;
}

float get_cpu_load(void) {
    if (!read_file(buf, "/proc/loadavg")) {
        return 0;
    }

    float load = atof(buf);
    return load * 100 / 16;
}

tuple_t get_memory_info(void) {
    if (!read_file(buf, "/proc/meminfo")) {
        return (tuple_t) {0, 0};
    }

    char *needle = "MemTotal:    ";
    char *s = strstr(buf, needle);
    if (!s) {
        return (tuple_t) {0, 0};
    }
    s += strlen(needle);
    int total = atoi(s);

    needle = "MemFree:        ";
    s = strstr(buf, needle);
    if (!s) {
        return (tuple_t) {0, 0};
    }
    s += strlen(needle);
    int available = atoi(s);
    return (tuple_t) {(total - available) / 1024, total / 1024};
}

int main() {
  char time_fmt[64];

  while (1) {
    int battery = get_battery_level();
    char battery_status = get_battery_status() == -1 ? '-' : '+';
    float cpu_load = get_cpu_load();
    tuple_t memory_info = get_memory_info();
    time_t now = time(NULL);
    strftime(time_fmt, 64, "%Y-%m-%d %X", localtime(&now));
    printf("CPU %.0f%% | MEM %d / %d MB | BAT %d%%%c | %s\n", cpu_load, memory_info.first, memory_info.second, battery, battery_status, time_fmt);
    fflush(stdout);
    sleep(1);
  }
}
