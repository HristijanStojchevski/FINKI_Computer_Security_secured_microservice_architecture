# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html
from service.mail_service import send_receipt


class ReceiptCrawlerPipeline(object):
    def process_item(self, item, spider):
        print('printing from pipeline')
        html_content = ''.join(item['content']['body'])
        send_receipt(html_content, item['mail'])
        return item['content']
