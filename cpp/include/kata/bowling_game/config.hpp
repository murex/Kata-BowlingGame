#ifndef BOWLING_GAME_CONFIG
#define BOWLING_GAME_CONFIG

#ifdef _MSC_VER
#ifdef BOWLING_GAME_EXPORTS
#define BOWLING_GAME_API __declspec(dllexport)
#else
#define BOWLING_GAME_API __declspec(dllimport)
#endif
#else
#define BOWLING_GAME_API
#endif

#endif // BOWLING_GAME_CONFIG
