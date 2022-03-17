



#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>




typedef struct {
	ngx_flag_t enable;
} ngx_http_prefix_filter_conf_t;

typedef struct {
	ngx_int_t add_prefix;
} ngx_http_prefix_filter_ctx_t;

static ngx_int_t ngx_http_prefix_filter_init(ngx_conf_t *cf);
static ngx_int_t ngx_http_prefix_filter_header_filter(ngx_http_request_t *r);
static ngx_int_t ngx_http_prefix_filter_body_filter(ngx_http_request_t *r, ngx_chain_t *in);

static ngx_str_t filter_prefix = ngx_string("<h2>Author : King</h2><p><a href=\"http://www.0voice.com\">0voice</a></p>");

static void *ngx_http_prefix_filter_create_conf(ngx_conf_t *cf) {

	ngx_http_prefix_filter_conf_t *conf = ngx_pcalloc(cf->pool, sizeof(ngx_http_prefix_filter_conf_t));
	if (conf == NULL) {
		return NULL;
	}

	conf->enable = NGX_CONF_UNSET;

	return conf;
}


static char *ngx_http_prefix_filter_merge_conf(ngx_conf_t *cf, void *parent, void *child) {
	ngx_http_prefix_filter_conf_t *prev = (ngx_http_prefix_filter_conf_t*)parent;
	ngx_http_prefix_filter_conf_t *conf = (ngx_http_prefix_filter_conf_t*)child;

	ngx_conf_merge_value(conf->enable, prev->enable, 0);

	return NGX_CONF_OK;
}

static ngx_command_t ngx_http_prefix_filter_commands[] = {
	{
		ngx_string("add_prefix"),
		NGX_HTTP_MAIN_CONF|NGX_HTTP_SRV_CONF|NGX_HTTP_LOC_CONF|NGX_HTTP_LMT_CONF|NGX_CONF_FLAG,
		ngx_conf_set_flag_slot,
		NGX_HTTP_LOC_CONF_OFFSET,
		offsetof(ngx_http_prefix_filter_conf_t, enable),
		NULL
	},
	ngx_null_command
};

static ngx_http_module_t ngx_http_prefix_filter_module_ctx = {
	NULL,
	ngx_http_prefix_filter_init,
	NULL,
	NULL,
	NULL,
	NULL,
	ngx_http_prefix_filter_create_conf,
	ngx_http_prefix_filter_merge_conf
};


ngx_module_t ngx_http_prefix_filter_module = {
	NGX_MODULE_V1,
	&ngx_http_prefix_filter_module_ctx,
	ngx_http_prefix_filter_commands,
	NGX_HTTP_MODULE,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NGX_MODULE_V1_PADDING
}; 

static ngx_http_output_header_filter_pt ngx_http_next_header_filter;
static ngx_http_output_body_filter_pt ngx_http_next_body_filter;



static ngx_int_t ngx_http_prefix_filter_init(ngx_conf_t *cf) {

	ngx_http_next_header_filter = ngx_http_top_header_filter;
	ngx_http_top_header_filter = ngx_http_prefix_filter_header_filter;

	ngx_http_next_body_filter = ngx_http_top_body_filter;
	ngx_http_top_body_filter = ngx_http_prefix_filter_body_filter;

	return NGX_OK;
}

static ngx_int_t ngx_http_prefix_filter_header_filter(ngx_http_request_t *r) {

	ngx_http_prefix_filter_ctx_t *ctx;
	ngx_http_prefix_filter_conf_t *conf;

	if (r->headers_out.status != NGX_HTTP_OK) {
		return ngx_http_next_header_filter(r);
	}

	ctx = ngx_http_get_module_ctx(r, ngx_http_prefix_filter_module);
	if (ctx) {
		return ngx_http_next_header_filter(r);
	}

	conf = ngx_http_get_module_loc_conf(r, ngx_http_prefix_filter_module);
	if (conf == NULL) {
		return ngx_http_next_header_filter(r);
	}
	if (conf->enable == 0) {
		return ngx_http_next_header_filter(r);
	}


	ctx = ngx_pcalloc(r->pool, sizeof(ngx_http_prefix_filter_ctx_t));
	if (ctx == NULL) {
		return NGX_ERROR;
	}
	ctx->add_prefix = 0;

	ngx_http_set_ctx(r, ctx, ngx_http_prefix_filter_module);

	if (r->headers_out.content_type.len >= sizeof("text/html") - 1
		&& ngx_strncasecmp(r->headers_out.content_type.data, (u_char*)"text/html", sizeof("text/html")-1) == 0) {

		ctx->add_prefix = 1;
		if (r->headers_out.content_length_n > 0) {
			r->headers_out.content_length_n += filter_prefix.len;
		}

		
	}

	return ngx_http_prefix_filter_header_filter(r);
}

static ngx_int_t ngx_http_prefix_filter_body_filter(ngx_http_request_t *r, ngx_chain_t *in) {
	
	ngx_http_prefix_filter_ctx_t *ctx = ngx_http_get_module_ctx(r, ngx_http_prefix_filter_module);
	if (ctx == NULL || ctx->add_prefix != 1) {
		return ngx_http_next_body_filter(r, in);
	}
	
	ctx->add_prefix = 2;

	ngx_buf_t *b = ngx_create_temp_buf(r->pool, filter_prefix.len);
	b->start = b->pos = filter_prefix.data;
	b->last = b->pos + filter_prefix.len;

	ngx_chain_t *cl = ngx_alloc_chain_link(r->pool);
	cl->buf = b;
	cl->next = in;

	return ngx_http_next_body_filter(r, cl);
}








