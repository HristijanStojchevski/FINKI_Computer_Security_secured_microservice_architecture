from multiprocessing import Process, Queue

from scrapy.crawler import CrawlerRunner
from scrapy.utils.project import get_project_settings
from twisted.internet import reactor

from .receipt_crawler.spiders.ReceiptCrawler import ReceiptCrawler


def f(q, url, mail):
    try:
        settings = get_project_settings()
        settings.set('ITEM_PIPELINES', {
            'receipt_crawler.receipt_crawler.pipelines.ReceiptCrawlerPipeline': 1,
        })

        runner = CrawlerRunner(settings)
        deferred = runner.crawl(ReceiptCrawler, url=url, mail = mail)
        deferred.addBoth(lambda _: reactor.stop())
        reactor.run()
        q.put(None)
    except Exception as e:
        q.put(e)

def crawl(url, mail):
    q = Queue()
    p = Process(target=f, args=(q,url,mail))
    p.start()
    p.join()




