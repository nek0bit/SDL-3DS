#include <3ds.h>

#ifndef _SDL_H
#define _SDL_H

#include "SDL_main.h"
#include "SDL_stdinc.h"
#include "SDL_assert.h"
#include "SDL_atomic.h"
#include "SDL_audio.h"
#include "SDL_clipboard.h"
#include "SDL_cpuinfo.h"
#include "SDL_endian.h"
#include "SDL_error.h"
#include "SDL_events.h"
#include "SDL_filesystem.h"
#include "SDL_joystick.h"
#include "SDL_gamecontroller.h"
#include "SDL_haptic.h"
#include "SDL_hints.h"
#include "SDL_loadso.h"
#include "SDL_log.h"
#include "SDL_messagebox.h"
#include "SDL_mutex.h"
#include "SDL_power.h"
#include "SDL_render.h"
#include "SDL_rwops.h"
#include "SDL_system.h"
#include "SDL_thread.h"
#include "SDL_timer.h"
#include "SDL_version.h"
#include "SDL_video.h"
#include "SDL_hints.h"

#include "begin_code.h"
/* Set up for C function definitions, even when using C++ */
#ifdef __cplusplus
extern "C" {
#endif

extern int SDL_RecreateWindow(SDL_Window * window, Uint32 flags);


static SDL_Renderer *N3DS_CreateRenderer(SDL_Window * window, Uint32 flags);
static void N3DS_WindowEvent(SDL_Renderer * renderer,
                             const SDL_WindowEvent *event);
static int N3DS_CreateTexture(SDL_Renderer * renderer, SDL_Texture * texture);
static int N3DS_UpdateTexture(SDL_Renderer * renderer, SDL_Texture * texture,
                              const SDL_Rect * rect, const void *pixels,
                              int pitch);
static int N3DS_LockTexture(SDL_Renderer * renderer, SDL_Texture * texture,
                            const SDL_Rect * rect, void **pixels, int *pitch);
static void N3DS_UnlockTexture(SDL_Renderer * renderer,
                               SDL_Texture * texture);
static int N3DS_SetRenderTarget(SDL_Renderer * renderer,
                                 SDL_Texture * texture);
static int N3DS_UpdateViewport(SDL_Renderer * renderer);
static int N3DS_RenderClear(SDL_Renderer * renderer);
static int N3DS_RenderDrawPoints(SDL_Renderer * renderer,
                                 const SDL_FPoint * points, int count);
static int N3DS_RenderDrawLines(SDL_Renderer * renderer,
                                const SDL_FPoint * points, int count);
static int N3DS_RenderFillRects(SDL_Renderer * renderer,
                                const SDL_FRect * rects, int count);
static int N3DS_RenderCopy(SDL_Renderer * renderer, SDL_Texture * texture,
                           const SDL_Rect * srcrect,
                           const SDL_FRect * dstrect);
static int N3DS_RenderReadPixels(SDL_Renderer * renderer, const SDL_Rect * rect,
                    Uint32 pixel_format, void * pixels, int pitch);
static int N3DS_RenderCopyEx(SDL_Renderer * renderer, SDL_Texture * texture,
                         const SDL_Rect * srcrect, const SDL_FRect * dstrect,
                         const double angle, const SDL_FPoint *center, const SDL_RendererFlip flip);
static void N3DS_RenderPresent(SDL_Renderer * renderer);
static void N3DS_DestroyTexture(SDL_Renderer * renderer,
                                SDL_Texture * texture);
static void N3DS_DestroyRenderer(SDL_Renderer * renderer);
void GPU_SetViewport(u32* depthBuffer, u32* colorBuffer, u32 x, u32 y, u32 w, u32 h);
void GPU_SetTexEnv(u8 id, u16 rgbSources, u16 alphaSources, u16 rgbOperands, u16 alphaOperands, GPU_COMBINEFUNC rgbCombine, GPU_COMBINEFUNC alphaCombine, u32 constantColor);
	void GPU_SetAttributeBuffers(u8 totalAttributes, u32* baseAddress, u64 attributeFormats, u16 attributeMask, u64 attributePermutation, u8 numBuffers, u32 bufferOffsets[], u64 bufferPermutations[], u8 bufferNumAttributes[]);
	void GPU_DrawArray(GPU_Primitive_t primitive, u32 first, u32 count);
	void GPU_SetFloatUniform(GPU_SHADER_TYPE type, u32 startreg, u32* data, u32 numreg);
	void GPU_SetAlphaBlending(GPU_BLENDEQUATION colorEquation, GPU_BLENDEQUATION alphaEquation,
							  GPU_BLENDFACTOR colorSrc, GPU_BLENDFACTOR colorDst,
							  GPU_BLENDFACTOR alphaSrc, GPU_BLENDFACTOR alphaDst);
	void GPU_SetTexture(GPU_TEXUNIT unit, u32* data, u16 width, u16 height, u32 param, GPU_TEXCOLOR colorType);
/* Ends C function definitions when using C++ */
#ifdef __cplusplus
}
#endif
#include "close_code.h"

#endif /* _SDL_H */
