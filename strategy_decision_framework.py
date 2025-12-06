"""
使用标准库生成策略决策层框架图（SVG）。
"""
from __future__ import annotations

import os
from dataclasses import dataclass
from html import escape
from typing import Iterable


@dataclass
class Box:
    x: int
    y: int
    width: int
    height: int
    text: str
    fill: str


@dataclass
class Arrow:
    start: tuple[int, int]
    end: tuple[int, int]
    text: str | None = None
    curved: bool = False
    curve_offset: tuple[int, int] | None = None


SVG_HEADER = """<svg xmlns='http://www.w3.org/2000/svg' width='1000' height='600' viewBox='0 0 1000 600'>
  <defs>
    <marker id='arrow' viewBox='0 0 10 10' refX='8' refY='5' markerWidth='6' markerHeight='6' orient='auto-start-reverse'>
      <path d='M 0 0 L 10 5 L 0 10 z' fill='#3c4043'/>
    </marker>
  </defs>
  <style>
    text { font-family: "DejaVu Sans", Arial, sans-serif; fill: #202124; font-size: 14px; }
    .label { font-size: 13px; }
    .subtitle { font-size: 12px; fill: #5f6368; }
    .arrow { stroke: #3c4043; stroke-width: 2; fill: none; marker-end: url(#arrow); }
    .box { stroke: #1b1f23; stroke-width: 2; rx: 12; ry: 12; }
  </style>
"""


def _render_box(box: Box) -> str:
    lines = [escape(line) for line in box.text.split("\n")]
    text_y = box.y + 26
    tspans = []
    for idx, line in enumerate(lines):
        dy = 0 if idx == 0 else 20
        tspans.append(f"    <tspan x='{box.x + box.width / 2}' dy='{dy}' text-anchor='middle'>{line}</tspan>")
    tspans_str = "\n".join(tspans)
    return (
        f"  <rect class='box' x='{box.x}' y='{box.y}' width='{box.width}' height='{box.height}' fill='{box.fill}' />\n"
        f"  <text x='{box.x + box.width / 2}' y='{text_y}' text-anchor='middle'>\n{tspans_str}\n  </text>\n"
    )


def _render_arrow(arrow: Arrow) -> str:
    if arrow.curved and arrow.curve_offset:
        cx, cy = arrow.curve_offset
        path = (
            f"  <path class='arrow' d='M {arrow.start[0]} {arrow.start[1]} Q {cx} {cy} {arrow.end[0]} {arrow.end[1]}' />\n"
        )
    else:
        path = (
            f"  <line class='arrow' x1='{arrow.start[0]}' y1='{arrow.start[1]}' x2='{arrow.end[0]}' y2='{arrow.end[1]}' />\n"
        )

    label = ""
    if arrow.text:
        mid_x = (arrow.start[0] + arrow.end[0]) / 2
        mid_y = (arrow.start[1] + arrow.end[1]) / 2 - 6
        label = f"  <text class='label' x='{mid_x}' y='{mid_y}' text-anchor='middle'>{escape(arrow.text)}</text>\n"
    return path + label


def _render_svg(boxes: Iterable[Box], arrows: Iterable[Arrow]) -> str:
    svg_parts = [SVG_HEADER]
    for box in boxes:
        svg_parts.append(_render_box(box))
    for arrow in arrows:
        svg_parts.append(_render_arrow(arrow))
    svg_parts.append("</svg>\n")
    return "".join(svg_parts)


def build_diagram(path: str) -> None:
    boxes = [
        Box(70, 60, 260, 140, "高层规划层\n（慢思考）\n\n任务图语义 / 阶段性目标 / 策略模式提示", "#d7e3f4"),
        Box(360, 60, 320, 140, "高层引导 + 中层门控\n基于策略模式提示的加权/门控机制", "#e7f2d8"),
        Box(60, 250, 210, 170, "环境观测 + 短期记忆\n\n实时态势、历史轨迹、威胁信息", "#f6e8d7"),
        Box(340, 230, 360, 210, "轻量策略模型库\n\n· 区域覆盖搜索\n· 目标跟踪与重识别\n· 编队突防与威胁规避\n· 物资投送与补给\n· 巡航与边界警戒", "#dfe8f5"),
        Box(740, 260, 200, 160, "策略执行 / 动作输出\n轨迹生成、任务调度、集群协同", "#f2d7ee"),
        Box(340, 470, 360, 110, "长期知识库 / 策略偏好\n任务成功率、资源利用率、模式偏好迭代", "#f7f3d7"),
    ]

    arrows = [
        Arrow((330, 130), (360, 130), "策略模式提示"),
        Arrow((270, 335), (340, 335), "观测/记忆上下文"),
        Arrow((520, 200), (520, 230)),
        Arrow((520, 230), (520, 280), "权重/门控"),
        Arrow((700, 335), (740, 340), "选中策略输出"),
        Arrow((740, 340), (650, 500), "执行反馈", curved=True, curve_offset=(780, 470)),
        Arrow((520, 470), (520, 430), "长期偏好"),
        Arrow((450, 470), (450, 440), "离线预训练"),
        Arrow((590, 470), (590, 440), "在线微调"),
    ]

    footer_note = "输出偏好：优先规避 / 优先效率"
    footer_text = f"  <text class='subtitle' x='{800}' y='{120}' text-anchor='middle'>{escape(footer_note)}</text>\n"

    svg_content = _render_svg(boxes, arrows).replace("</svg>\n", footer_text + "</svg>\n")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as fp:
        fp.write(svg_content)


if __name__ == "__main__":
    output_path = os.path.join("docs", "strategy_decision_framework.svg")
    build_diagram(output_path)
    print(f"Saved diagram to {output_path}")
