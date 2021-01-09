#include <iostream>
#include <fstream>
#include <string>

#include <ncurses.h>

using namespace std;

// ============================================================================

int main(int argc, char* argv[])
{
    auto input = ifstream(argv[1]);

    initscr();
    start_color();

    for (auto i = 1; i < 8; ++i)
	    init_pair(i, i, i);

    auto line = ""s;
    while (getline(input, line))
    {
        static auto y = -1;
        auto x = 0; ++y;
        auto colour = 0;
        auto hold = false;
        line.pop_back();

        for (const auto& i: line)
        {
            switch (i)
            {
                case ' ':
                    if (!hold) colour = COLOR_BLACK; break;
                case '/':
                    colour = COLOR_GREEN; hold = true; break;
                case '\\':
                    colour = COLOR_GREEN; hold = false; break;
                case '|': colour = COLOR_BLACK; hold = !hold; break;
                case '^': colour = COLOR_YELLOW; break;
                case '~': colour = COLOR_RED; break;
                case '`': colour = COLOR_BLUE; break;
                case '*': colour = COLOR_MAGENTA; break;
                case '&': colour = COLOR_WHITE; break;
                case '+': colour = COLOR_CYAN; break;
            }

            attron(COLOR_PAIR(colour));
            mvwprintw(stdscr, y, x++, "%c", ' ');
            attroff(COLOR_PAIR(colour));
        }

        refresh();
    }

    getch();
	endwin();
}

// ============================================================================