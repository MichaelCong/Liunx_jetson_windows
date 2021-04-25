# -*- coding: utf-8 -*-

import numpy as np
import cv2 as cv

cap = cv.VideoCapture(0)  # 创建一个VideoCapture对象
while (True):

    ret, frame = cap.read()  # 一帧一帧读取视频
    gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)  # 对每一帧做处理,设置为灰度图
    cv.imshow('frame', frame)  # 显示结果
    if cv.waitKey(1) & 0xFF == ord('q'):  # 按q停止
        break

cap.release()  # 释放cap,销毁窗口
cv.destroyAllWindows()